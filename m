From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Announcing: USB support for Ryuichi Oikawa's Accelerated Xpmac Xserver for Rage 128
Date: Sat, 30 Oct 1999 12:50:17 -0400
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99103012584000.00426@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Borrowing heavily from the usb kernel driver, Samuel's mouse support from MOL
and Sun's X server (which Xpmac is based on), I have added usb mouse support to
Ryuichi Oikawa's Xpmac Xserver  which is accelerated for Rage 128.

So now you can get fast graphics performance on your G3, while now using your
usb mouse (an adb mouse will still work).

This work is preliminary:

You can download a the patch to add usb to Xpmac along with a new Xpmac binary
from the following url:

http://khendricks.ivey.uwo.ca/rage128_usb/

To install:

gunzip Xpmac.rage128.usb.gz
cp Xpmac.rage128.usb /usr/X11R6/bin/
cd /etc/X11
rm X
ln -s ../../usr/X11R6/bin/Xpmac.rage128.usb X
startx

Any feedback is greatly appreciated.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
