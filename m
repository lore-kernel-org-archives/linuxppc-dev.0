Message-ID: <885489B3B89FB6449F93E525DF78777F064559@srvnt506.ALLOPTIC.COM>
From: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: MTD device
Date: Mon, 20 Jan 2003 11:25:36 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I am in the process of setting up the MTD driver to access my onboard flash,
and ran into some problem here.

I have followed the howto of "mtd-jffs-howto.txt" to configure the kernel to
have the MTD support as build-in support.

I am running 2.4.7 kernel source code from TimeSys.

Looks like the kernel did recognize the flash device and when use the
following command
> cat /proc/mtd

dev:	size	erasesize	name
mtd0: 01000000 00040000	"Physically mapped flash"


---------
However, I do not see /dev/mtdx under the /dev directory.  Is there
something I am missing here?

Ultimately I will like to mount the JFFS2 on the MTD, and will appreciate
any help out there.

Thanks

Cecilia

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
