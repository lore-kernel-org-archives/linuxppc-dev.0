From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel can't library file
Date: Wed, 12 Jul 2000 22:10:32 +0900
Message-ID: <NEBBKFENMLEDKDHMEHPJOEPBCAAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I heard the solution for network configuration was three.

1) etc/protocols, services
2) /proc
3) same compiler version between kernel, program, and library.

first 2 solution had no effect.

So I searched for the program and library 2.1.2(2.1.1?)

I use montavista developement kit and I found root file system in target directory.

It was very huge, so I copy just few files to ramdisk.

but kernel shows such a message.


-----------

ttyS00 at 0x0380 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 8192K size
eth0: CPM ENET Version 0.2, 00:01:c4:00:00:b1
IP-Config: Incomplete network configuration information.
dev_close: bug eth0 still running
RAMDISK: Compressed image found at block 0
RAMDISK: Decompressed successfullyVFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 32k init

?nit: error in loading shared libraries: libdl.so.2: cannot open shared object
file: No such file or directory

----------

in lib directory there are

ld.so.1 libdl.so.2 libc.so.6

it's for bash program. I think bash prompt should be present.

anyone had such a problem?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
