#!/sbin/busybox2 sh

(
	BB=/sbin/busybox2
	PROFILE=$(cat /data/.shift/.active.profile);
	. /data/.shift/${PROFILE}.profile;

	if [ "$cron_ram_release" == "on" ]; then
		if [ "$($BB pidof com.google.android.gms | wc -l)" -eq "1" ]; then
			$BB kill $($BB pidof com.google.android.gms);
		fi;
		if [ "$($BB pidof com.google.android.gms.unstable | wc -l)" -eq "1" ]; then
			$BB kill $($BB pidof com.google.android.gms.unstable);
		fi;
		if [ "$($BB pidof com.google.android.gms.persistent | wc -l)" -eq "1" ]; then
			$BB kill $($BB pidof com.google.android.gms.persistent);
		fi;
		if [ "$($BB pidof com.google.android.gms.wearable | wc -l)" -eq "1" ]; then
			$BB kill $($BB pidof com.google.android.gms.wearable);
		fi;
		date +%H:%M-%D-%Z > /data/crontab/cron-ram-release;
		echo "Ram Released" >> /data/crontab/cron-ram-release;
	fi;
)&
