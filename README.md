# Create USB stick with multi os inside


## Documentation

* [tutorial](https://linuxconfig.org/how-to-create-multiboot-usb-with-linux)
* [gnu documentation](https://www.gnu.org/software/grub/manual/grub/grub.html)
## find your usb key in the list

```lsblk```

in my case, it'd sda

## format the usb key in fat32

1. umount it
```sudo umount /dev/sda1```

2.

```
sudo parted -s /dev/sda mklabel msdos
sudo parted -s /dev/sda mkpart primary 1MiB 551MiB
sudo parted -s /dev/sda set 1 esp on
sudo parted -s /dev/sda set 1 boot on
sudo mkfs.fat -F32 /dev/sda1
sudo parted -s /dev/sda mkpart primary 551MiB 100%
sudo mkfs.ext4 /dev/sda2
sudo mkdir /media/{efi,data}
sudo mount /dev/sda2 /media/data
sudo mount /dev/sda1 /media/efi

sudo grub-install --target=i386-pc --recheck --boot-directory="/media/data/boot" /dev/sda
sudo grub-install --target=x86_64-efi --recheck --removable --efi-directory="/media/efi" --boot-directory="/media/data/boot"

sudo mkdir /media/data/boot/iso
sudo chown 1000:1000 /media/data/boot/iso
```

transfer your iso in the folder iso


