Message-ID: <20030220123426.43555.qmail@web8007.mail.in.yahoo.com>
Date: Thu, 20 Feb 2003 04:34:26 -0800 (PST)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: Romdisk
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have created a romfs image using the Genromfs .
DO i need to cat this image with the kernel image
(Vmlinux.gz) ?
I had created a single image using the command
./mkimage -A ppc -O Linux -T multi  -C gzip \
        -n 'Linux-2.4.4 Multiboot-Image' -e 0 -a 0 \
        -d vmlinux.gz:romfs.img Romimage

I have given the Bootargs as "root=/dev/mtdblock0"
I have enabled  the romfs file system option as well
as MTd block device option in the kernel.

Wheni download this multiimage kernel i get the error
like
VFS: Mounted root (romfs filesystem) readonly.
Kernel panic: I have no root and I want to scream

please tell me how does the kernel recognise  the
start of the romfs.and where should the romfs be
loaded ?









Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
