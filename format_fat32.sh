# set your usb key

# 0. Format 
# 1. Mount
# 2. Umount

Error_msg () {
	echo -------------------------
	echo error, try...
	echo -------------------------
	echo sudo $0 format
	echo sudo $0 mount
	echo sudo $0 umount
}

if [ -z "$1" ]
then
	Error_msg
	exit 0
fi

usb="/dev/sdc"
dat=$usb"1"
efi=$usb"2"

echo -------------------------
echo PARTITION OF YOUR USB KEY
echo -------------------------
echo -e "USB\t: $usb"
echo -e "dat\t: $dat"
echo -e "efi\t: $efi"
echo -------------------------

if [ $1 = "format" ]
then
	echo partition...
	sudo parted -s $usb mklabel msdos
	sudo parted -s $usb mkpart primary 1MiB 551MiB
	sudo parted -s $usb set 1 esp on
	sudo parted -s $usb set 1 boot on
	sudo mkfs.fat -F32 $dat
	sudo parted -s $usb mkpart primary 551MiB 100%
	sudo mkfs.ext4 $efi
	exit 0
fi



if [ $1 = "mount" ]
then
	echo is mounting...
	sudo mkdir -p /media/{efi,dat}
	sudo mount $efi /media/efi
	sudo mount $dat /media/dat
	exit 0
fi



if [ $1 = "umount" ]
then
	echo is umounting...
	sudo umount /media/data
	sudo umount /media/efi
	exit 0
fi

Error_msg


