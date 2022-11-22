#!/bin/bash
function backup_usb_stick {
uuid_extd="63DF-F728"
log_name_extd="$(readlink -e /dev/disk/by-uuid/$uuid_extd)"
if [ -z "$log_name_extd" ] ; then
	echo "External drive not plugged in. Backup will not be executed. You dumb fuck!!!"
	exit 0
fi

MOUNTPOINT_extd=$(lsblk $log_name_extd -n -o MOUNTPOINT)
# echo $log_name_extd $MOUNTPOINT_extd

# # directories to skip, starting from home-directory
# dir1="Dokumente/Uni/Promotion/Messzeit_DELTA_0222/Daten/TIF"
# dir2="Dokumente/Uni/Promotion/Messzeit_DELTA_0521/Daten/TIF"
# dir3="Dokumente/Uni/Promotion/Messzeit_DELTA_0719/run11_19_hexrr_inhouse/det_img"
# dir4="Dokumente/Uni/Promotion/Messzeit_DELTA_0820/Daten/TIF"
# dir5="Dokumente/Uni/Promotion/Messzeit_DELTA_0921/Daten/TIF"
# dir6="Dokumente/Uni/Promotion/Messzeit_DELTA_1119"
# dir7="Dokumente/Uni/Promotion/Messzeit_ID31_1021/data"
# dir8="Dokumente/Uni/Promotion/Messzeit_P08_2020/Daten/TIF"
# dir9=".thunderbird"
# dir10=".cache"
# dir11=".mozilla"

files_to_save="/home/Kononov/Documents/DigiLab-Backup/BACKUP/PHD_theses/"
save_folder_extd_for_files="$MOUNTPOINT_extd/PHD_Theses/"
printf "Do you want to copy \n$files_to_save\n\t to \n$save_folder_extd_for_files \n[y/n]?"
read input
if [ "$input" == "y" ] ; then
    rsync -av --delete-before --progress $files_to_save $save_folder_extd_for_files
else
	echo "Backup aborted"
fi
}
