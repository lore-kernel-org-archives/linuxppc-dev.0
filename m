From: linuxppcdev@qbjnet.com
Date: 16 Mar 2004 17:47:23 -0600
Message-ID: <20040316234723.18931.qmail@kunk.qbjnet.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Can't get 7248 PreP boot disk working in 2.6
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Running an IDE disk and booting off floppy (cheap dual boot, can use the
hard drive to boot AIX this way).

I've never had trouble making a boot disk for 2.4.x kernels. Using the
current bitkeeper 2.4 and 2.6 however, the 2.4 works fine and the 2.6
reads a few sectors and goes to the System Maint disk insert dialog.
Tried different floppies, etc.

To make these I do a make zImage then dd the resulting
zImage.prep to a floppy.

I know there is some odd kernel size limitation which is less than the
actual size of the floppy but that isn't the problem.

# ls -l  bk*/arch/ppc/boot/images/zImage.prep
-rwxr-xr-x    1 root     nogroup   1210629 Mar 16 11:11 bk24/arch/ppc/boot/images/zImage.prep
-rwxr-xr-x    1 root     nogroup   1028225 Mar 16 16:43 bk26/arch/ppc/boot/images/zImage.prep

The 2.4 image is actually larger than the 2.6 image (more stuff in modules
in the 2.6 compile).

# file bk*/arch/ppc/boot/images/zImage.prep
bk24/arch/ppc/boot/images/zImage.prep: x86 boot sector
bk26/arch/ppc/boot/images/zImage.prep: x86 boot sector

I have 2.6.4 running on some macs, even a 7200 so I'm curious if
anyone has clues about this problem?

Bob

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
