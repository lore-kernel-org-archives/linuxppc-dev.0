From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Is the ramdisk mounted?
Date: Sat, 8 Jul 2000 09:40:26 +0900
Message-ID: <NEBBKFENMLEDKDHMEHPJIEOGCAAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just mounted the ramdisk with a warning.

Is there any problem with unchecked fs? But I copied the image to host 'dd if=ramdisk.image of=/dev/ram' and I worked well. (It was given 2.2.13 kernel on linuxppc.org)

Anyway, actual problem appeared at calling at init process. I saw the source and it seems if there is no init then the kernel calls /bin/sh.

Of coarse, the shell is in the image, but the kernel couldn't find it.

---------------------------


Now booting the kernel
ttyS00 at 0x0380 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
eth0: CPM ENET Version 0.2, 00:01:c4:00:00:b1
RAMDISK: Compressed image found at block 0
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 28k init
Warning: unable to open an initial console.
Kernel panic: No init found.  Try passing init= option to kernel.
Rebooting in 180 seconds..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
