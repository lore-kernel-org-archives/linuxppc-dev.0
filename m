Date: Thu, 17 Feb 2000 10:58:50 -0800 (PST)
From: Brad Midgley <brad@turbolinux.com>
To: Paul Mackerras <paulus@linuxcare.com>
cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: kernel powerbook sleep docs
In-Reply-To: <00011313582505.00484@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.20.0002171039050.5987-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


this isn't well-documented. here's a start at improving it...

diff -ur ../linux-pmac-devel-orig/Documentation/Configure.help ./Documentation/Configure.help
--- ../linux-pmac-devel-orig/Documentation/Configure.help       Thu Feb 10 16:19:48 2000
+++ ./Documentation/Configure.help      Thu Feb 17 11:58:03 2000
@@ -2391,6 +2391,22 @@
   includes a server that supports the frame buffer device directly
   (XF68_FBDev).

+Power management support for PowerBooks
+CONFIG_PMAC_PBOOK
+  This provides support for putting a PowerBook to sleep; it also
+  enables media bay support. Power management works on the
+  PB2400/3400/3500, Wallstreet, Lombard, and Bronze PowerBook G3. You
+  must get the power management daemon, pmud, to make it work and you
+  must have the /dev/pmu device (see the pmud README).
+
+  Get pmud from ftp://linuxcare.com.au/pub/ppclinux/pmud/
+
+  If you have a PowerBook, you should say Y.
+
+  You may also want to compile the dma sound driver as a module and
+  have it autoloaded. The act of removing the module shuts down the
+  sound hardware for more power savings.
+
 Matrox unified accelerated driver (EXPERIMENTAL)
 CONFIG_FB_MATROX
   Say Y here if you have Matrox Millennium, Matrox Millennium II,


Brad
brad@turbolinux.com | http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
