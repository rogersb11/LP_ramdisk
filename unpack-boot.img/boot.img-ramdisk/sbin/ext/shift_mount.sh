#!/sbin/busybox sh

BB=/sbin/busybox

#cache partition.
$BB mount -t ext4 -o noatime,data=writeback,barrier=0,nosuid,nodev,journal_async_commit,errors=panic /dev/block/mmcblk0p12 /cache
if ! $BB grep -q /cache /proc/mounts ; then
	$BB mount -t f2fs -o rw /dev/block/mmcblk0p12 /cache
fi

# data partition.
$BB mount -t ext4 -o noatime,data=writeback,barrier=0,nosuid,nodev,discard,noauto_da_alloc,journal_async_commit,errors=panic /dev/block/mmcblk0p16 /data
if  ! $BB grep -q /data /proc/mounts ; then
	$BB mount -t f2fs -o noatime,nodiratime,discard,nosuid,nodev /dev/block/mmcblk0p16 /data
fi