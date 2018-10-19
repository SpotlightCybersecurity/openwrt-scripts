#!/bin/sh
# Released to Public Domain

# Setup Legal Banner
cat > /etc/banner <<EOF
Authorized Users Only!
Any attempted or unauthorized access, use,
or modification is prohibited. Unauthorized
users may face criminal or civil penalties.
The use of this system may be monitored and
recorded. If monitoring reveals unauthorized
use than records may be provided to law
enforcement.
EOF
uci set 'dropbear.@dropbear[0].BannerFile=/etc/banner'
uci commit
