A collection of script useful for setting up new and maintaining existing OpenWRT boxes.

# banner_setup.sh
Setup a legal system notification banner for dropbear.

# rotatinglogwriter.sh
Instead of sending syslog data to a remote host, capture is locally in a rotating file. Requires the `timeout` utility from the `coreutils-timeout` package (or built-in to busybox, but openwrt stock firmwares don't have this). See the top of the script for configuration options.
