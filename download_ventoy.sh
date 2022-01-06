wget https://github.com/ventoy/Ventoy/releases/download/v1.0.63/ventoy-1.0.63-linux.tar.gz
tar -xvzf ventoy-1.0.63-linux.tar.gz
cd ventoy-1.0.63
sudo ./Ventoy2Disk.sh -i /dev/sdc
sudo apt install exfat-fuse

# add your os in the folder ventoy
