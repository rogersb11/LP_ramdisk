#!/sbin/busybox sh

read -t 5 -p "Start fixing DATA partition? 5sec time out then NO (y/n)"
if [ "$REPLY" == "y" ]; then
	if [ ! -e /data/dalvik_cache/ ]; then
		echo "starting to fix DATA"
		/sbin/e2fsck -fyc /dev/block/mmcblk0p16;
		/sbin/e2fsck -fyc /dev/block/mmcblk0p16;
		/sbin/e2fsck -p /dev/block/mmcblk0p16;
		/sbin/busybox mount -t ext4 /dev/block/mmcblk0p16 /data;
		/sbin/busybox rm -f /data/dalvik-cache/*;
		/sbin/busybox sync;
		/sbin/busybox umount /data;
		echo "All done!"
	else
		echo "DATA Partition is MOUNTED! you can't run this script, reboot to recovery, them run via ADB"
	fi;
fi;
