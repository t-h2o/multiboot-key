# set your usb key


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

sudo parted -s $usb mklabel msdos
sudo parted -s $usb mkpart primary 1MiB 551MiB
sudo parted -s $usb set 1 esp on
sudo parted -s $usb set 1 boot on
sudo mkfs.fat -F32 $dat
sudo parted -s $usb mkpart primary 551MiB 100%
sudo mkfs.ext4 $efi
sudo mkdir /media/{efi,dat}

#sudo mount $efi /media/efi
#sudo mount $dat /media/dat
