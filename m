Date: Tue, 7 May 2002 11:17:57 -0500 (CDT)
From: "Jeffrey W. Daugherty" <jwdaugherty@lucent.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Linux w/o disk, network, or ROM
Message-ID: <Pine.LNX.4.44.0205071100160.29700-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All,

I am trying to replace a proprietary OS on a proprietary
board that only has a PPC750 and 192MB of RAM.  The only
means of communication to this board is via shared memory.

I am able to configure the kernel with RAMDISK, and I can
boot the kernel along with an initrd image.  The kernel
recognizes the initrd image containing an ext2 root filesystem.
Using a simple console which dumps kernel text messages
to the share memory, I see the messages:

RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 4096 blocks [1 disk] into ramdisk...done
Freeing initrd memory: 4096k freed
Kernel panic: VFS: Unable to mount root fs 01:00

I've tried setting ROOT_DEV to MKDEV(RAMDISK, 0) in setup.c
and cmdline argument "root=/dev/ram".

Does anyone have any suggestions?  What might be missing either
in kernel configuration or platform_init()?  Help!

--
Jeffrey W. Daugherty
(630)713-6511
jwdaugherty@lucent.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
