From: "Kim, Kwansuk" <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MTD device
Date: Tue, 21 Jan 2003 13:53:38 +0900
Message-ID: <OMENKEONFDLIGLHPFALBOEDECNAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <885489B3B89FB6449F93E525DF78777F064559@srvnt506.ALLOPTIC.COM>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Why don't you make the node for MTD device?

If you don't use /dev filesystem, you should make the node by yourself

like this :
character device :
	mknod /dev/mtd0 c 90 0
block device :
	mknod /dev/mtdblock0 b 31 0

 ==============================================
     Just for fun...
                                                  - Linus Torvalds
 ==============================================
  Kwansuk Kim
  Engineer, NeoWave Inc.
  Tel   +82-31-380-4927    Fax +82-31-380-4747
  E-mail: kskim@neowave.co.kr
==============================================

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Muaddi, Cecilia
Sent: Tuesday, January 21, 2003 4:26 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: MTD device




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
