From: deepesh@india.tejasnetworks.com
Message-ID: <1057294269.3f0507bd27111@pop-mail.india.tejasnetworks.com>
Date: Fri, Fri 04 Jul 2003 10:21:09 AM IST, Jul 2003 10:21:09 +0530
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problems in the kernel for EP8260 Board.
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

  I am having an EP8260 Board. And the linux I am using is from TimeSys.
I made a gzipped ramdisk.image.gz. Following are the last few lines
before the board hung.

TCP: Hash tables configured (established 128 bind 210)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4389k freed
EXT2-fs warning: checktime reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /äv
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
modprobe: modprobe: Can't open dependencies file
/lib/modules/2.4.7-timesys-3.1.180/modules.dep
(N
)

Thank you,
Deepesh

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
