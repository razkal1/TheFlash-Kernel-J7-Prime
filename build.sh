#!/bin/bash
# Build Script By Tkkg1994
# Modified by TheFlash / XDA Developers

# ---------
# VARIABLES
# ---------
BUILD_SCRIPT=1.0
VERSION_NUMBER=$(<build/version)
ARCH=arm64
BUILD_CROSS_COMPILE=/usr/local/share/aarch64-linux-android-4.9/bin/aarch64-linux-android-
BUILD_JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`
RDIR=$(pwd)
OUTDIR=$RDIR/arch/$ARCH/boot
DTSDIR=$RDIR/arch/$ARCH/boot/dts
DTBDIR=$OUTDIR/dtb
DTCTOOL=$RDIR/scripts/dtc/dtc
INCDIR=$RDIR/include
PAGE_SIZE=2048
DTB_PADDING=0
KERNELNAME=Flash_Kernel
KERNELCONFIG=Flash_Kernel
ZIPLOC=zip
RAMDISKLOC=ramdisk

# Colours
bldred=${txtbld}$(tput setaf 1) # red
bldgrn=${txtbld}$(tput setaf 2) # green
bldblu=${txtbld}$(tput setaf 4) # blue
bldcya=${txtbld}$(tput setaf 6) # cyan
txtrst=$(tput sgr0) # Reset

# ---------
# FUNCTIONS
# ---------
FUNC_CLEAN()
{
make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
	CROSS_COMPILE=$BUILD_CROSS_COMPILE clean
make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
	CROSS_COMPILE=$BUILD_CROSS_COMPILE mrproper
rm -f $RDIR/build/build.log
rm -f $RDIR/build/build-G610x.log
rm -rf $RDIR/arch/arm64/boot/dtb
rm -f $RDIR/arch/$ARCH/boot/dts/*.dtb
rm -f $RDIR/arch/$ARCH/boot/boot.img-dtb
rm -f $RDIR/arch/$ARCH/boot/boot.img-zImage
rm -f $RDIR/build/boot.img
rm -f $RDIR/build/*.zip
rm -f $RDIR/build/$RAMDISKLOC/G610x/image-new.img
rm -f $RDIR/build/$RAMDISKLOC/G610x/ramdisk-new.cpio.gz
rm -f $RDIR/build/$RAMDISKLOC/G610x/split_img/boot.img-dtb
rm -f $RDIR/build/$RAMDISKLOC/G610x/split_img/boot.img-zImage
rm -f $RDIR/build/$RAMDISKLOC/G610x/image-new.img
rm -f $RDIR/build/$ZIPLOC/G610x/*.zip
rm -f $RDIR/build/$ZIPLOC/G610x/*.img
}

FUNC_BUILD_DTB()
{
[ -f "$DTCTOOL" ] || {
	echo "You need to run ./build.sh first!"
	exit 1
}
case $MODEL in
on7xelte)
	DTSFILES="exynos7870-on7xelte_ltn_open_00 exynos7870-on7xelte_ltn_open_01
		exynos7870-on7xelte_ltn_open_02 exynos7870-on7xelte_swa_open_00
		exynos7870-on7xelte_swa_open_01 exynos7870-on7xelte_swa_open_02"
	;;
*)
	echo "Unknown device: $MODEL"
	exit 1
	;;
esac
mkdir -p $OUTDIR $DTBDIR
cd $DTBDIR || {
	echo "Unable to cd to $DTBDIR!"
	exit 1
}
rm -f ./*
echo "Processing dts files."
for dts in $DTSFILES; do
	echo "=> Processing: ${dts}.dts"
	${CROSS_COMPILE}cpp -nostdinc -undef -x assembler-with-cpp -I "$INCDIR" "$DTSDIR/${dts}.dts" > "${dts}.dts"
	echo "=> Generating: ${dts}.dtb"
	$DTCTOOL -p $DTB_PADDING -i "$DTSDIR" -O dtb -o "${dts}.dtb" "${dts}.dts"
done
echo "Generating dtb.img."
$RDIR/scripts/dtbTool/dtbTool -o "$OUTDIR/dtb.img" -d "$DTBDIR/" -s $PAGE_SIZE
echo "Done."
}

FUNC_BUILD_ZIMAGE()
{
echo ""
echo "build common config="$KERNEL_DEFCONFIG ""
echo "build variant config="$MODEL ""
make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
	CROSS_COMPILE=$BUILD_CROSS_COMPILE \
	$KERNEL_DEFCONFIG || exit -1
make -j$BUILD_JOB_NUMBER ARCH=$ARCH \
	CROSS_COMPILE=$BUILD_CROSS_COMPILE || exit -1
echo ""
}

FUNC_BUILD_RAMDISK()
{
# check if kernel build ok
if [ ! -e $RDIR/arch/$ARCH/boot/Image ]; then
	echo -e "\n${bldred}Kernel Not build! Check Build.log ${txtrst}\n"
	grep -B 3 -C 6 -r error: $RDIR/build/build.log
	grep -B 3 -C 6 -r warn $RDIR/build/build.log
	read -n 1 -s -p "Press any key to continue"
else if [ ! -e $RDIR/arch/$ARCH/boot/dtb.img ]; then
	echo -e "\n${bldred}DTB Not Built! Check Build.log${txtrst}\n"
	grep -B 3 -C 6 -r error:$RDIR/build/build.loguild/build.log
	grep -B 3 -C 6 -r warn $RDIR/build/build.log
	read -n 1 -s -p "Press any key to continue"
fi
fi

if [ ! -f "$RDIR/build/ramdisk/G610x/ramdisk/config" ]; then
	mkdir $RDIR/build/ramdisk/G610x/ramdisk/config
	chmod 500 $RDIR/build/ramdisk/G610x/ramdisk/config
fi

mv $RDIR/arch/$ARCH/boot/Image $RDIR/arch/$ARCH/boot/boot.img-zImage
mv $RDIR/arch/$ARCH/boot/dtb.img $RDIR/arch/$ARCH/boot/boot.img-dtb
case $MODEL in
on7xelte)
	rm -f $RDIR/build/ramdisk/G610x/split_img/boot.img-zImage
	rm -f $RDIR/build/ramdisk/G610x/split_img/boot.img-dtb
	mv -f $RDIR/arch/$ARCH/boot/boot.img-zImage $RDIR/build/ramdisk/G610x/split_img/boot.img-zImage
	mv -f $RDIR/arch/$ARCH/boot/boot.img-dtb $RDIR/build/ramdisk/G610x/split_img/boot.img-dtb
	cd $RDIR/build/ramdisk/G610x
	./repackimg.sh
	echo SEANDROIDENFORCE >> image-new.img
	;;
*)
	echo "Unknown device: $MODEL"
	exit 1
	;;
esac
}

FUNC_BUILD_BOOTIMG()
{
	(
	FUNC_BUILD_ZIMAGE
	FUNC_BUILD_DTB
	FUNC_BUILD_RAMDISK
	) 2>&1	 | tee -a $RDIR/build/build.log
}

FUNC_BUILD_ZIP()
{
echo ""
echo "Building Zip File"
cd $ZIP_FILE_DIR
zip -gq $ZIP_NAME -r META-INF/ -x "*~"
zip -gq $ZIP_NAME -r system/ -x "*~" 
[ -f "$RDIR/build/$ZIPLOC/G610x/boot.img" ] && zip -gq $ZIP_NAME boot.img -x "*~"
chmod a+r $ZIP_NAME
mv -f $ZIP_FILE_TARGET $RDIR/build/$ZIP_NAME
cd $RDIR
}

OPTION_1()
{
rm -f $RDIR/build/build.log
MODEL=on7xelte
KERNEL_DEFCONFIG=Flash_Kernel_on7xelte_defconfig
START_TIME=`date +%s`
	(
	FUNC_BUILD_BOOTIMG
	) 2>&1	 | tee -a $RDIR/build/build.log
mv -f $RDIR/build/ramdisk/G610x/image-new.img $RDIR/build/$ZIPLOC/G610x/boot.img
mv -f $RDIR/build/build.log $RDIR/build/build-G610x.log
ZIP_DATE=`date +%Y%m%d`
ZIP_FILE_DIR=$RDIR/build/$ZIPLOC/G610x
ZIP_NAME=$KERNELNAME.G610x.v$VERSION_NUMBER.$ZIP_DATE.zip
ZIP_FILE_TARGET=$ZIP_FILE_DIR/$ZIP_NAME
FUNC_BUILD_ZIP
END_TIME=`date +%s`
let "ELAPSED_TIME=$END_TIME-$START_TIME"
echo ""
echo "Build Successful"
echo ""
echo "Compiled in $ELAPSED_TIME seconds"
echo ""
}

OPTION_0()
{
echo "${bldred} Cleaning Workspace ${txtrst}"
FUNC_CLEAN
}

if [ $1 == 0 ]; then
	OPTION_0
fi
if [ $1 == 1 ]; then
	OPTION_1
fi

# Program Start
rm -rf ./build/build.log
clear
echo "${bldred}"
echo " _ _ _ _ _ _                           _ _ _ _ _ _ _ _           _ _ _ _ _ _ _          |           |"
echo "|                 |                   |               |		|                       |           |"
echo "|                 |                   |               |		|                       |           |"
echo "|_ _ _ _ _        |                   |               |		|                       |           |"
echo "|                 |                   |_ _ _ _ _ _ _ _|		|_ _ _ _ _ _ _          |_ _ _ _ _ _|"
echo "|                 |                   |               |                       |         |           |"
echo "|                 |                   |               |                       |         |           |"
echo "|                 |                   |               |                       |         |           |"
echo "|                 |_ _ _ _ _ _ _      |               |		_ _ _ _ _ _ _ |         |           |"
echo "                                                                                                           @SN"
echo "${txtrst}"
echo " ${bldblu} 0) Clean Workspace ${txtrst}"
echo ""
echo " ${bldblu} 1) Build Flash_Kernel boot.img for J7 Prime ${txtrst}"
echo ""
read -p " ${bldcya}Please select an option: ${txtrst}" prompt
echo ""
if [ $prompt == "0" ]; then
	OPTION_0
	echo ""
	echo ""
	echo ""
	echo ""
	. build.sh
elif [ $prompt == "1" ]; then
	OPTION_1
	echo ""
	echo ""
	echo ""
	echo ""
	read -n 1 -s -p "Press any key to continue"
fi
