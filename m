Message-ID: <37D98144.97257D77@wanadoo.fr>
Date: Sat, 11 Sep 1999 00:08:04 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.3.18 and CONFIG_ADB_MOUSE
References: <Pine.LNX.4.10.9909101143540.23282-100000@mercator.cs.kuleuven.ac.be> <37D944A8.78051BB@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In the latest vger-2.3.18 and also Paul's linux-pmac-devel, the
ADB_MOUSE cannot be selected any more, neither in 'make oldconfig' nor
in 'make menuconfig'.

While the logic in drivers/char/Config.in:
 
if [ "$CONFIG_ADB" = "y" ; then
    dep_tristate 'Apple Desktop Bus mouse support' CONFIG_ADB_MOUSE
$CONFIG_BUSM
OUSE

looks OK, it doesn't work. This never shows up in 'make menuconfig'.

And in arch/ppc/config.in, the line

   bool 'Support for PowerMac ADB mouse' CONFIG_ADBMOUSE

got trashed, probably by mistake.

Well, I suppose the adb merging is not quite finished, like the irq and
pci parts. I got it to compile, but it doesn't boot.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
