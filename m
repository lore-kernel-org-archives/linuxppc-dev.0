Message-ID: <3D1961E6.AEB50722@imc-berlin.de>
Date: Wed, 26 Jun 2002 08:40:38 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: SELF and JFFS2????
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

has anyone successfully used DENX SELF to create an root fs _and_ put it then on
a JFFS2 partion?

I would like to create a flash disk just as easy as you can create a ramdisk
with SELF.
But for now the problem is that mkfs.jffs2 does _not_ handle (busybox) hardlinks
correctly - well at least not the way I want.

Thanks,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
