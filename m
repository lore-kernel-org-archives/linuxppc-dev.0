From: "Kwansuk Kim" <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Unable to mount root fs...
Date: Thu, 6 Jul 2000 21:19:02 +0900
Message-ID: <NEBBKFENMLEDKDHMEHPJEENPCAAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.21.0007060211240.6798-100000@gemini.home.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At last! My kernel started operating on the custom board.

but, soon it halted as followed.

I think the compress ramdisk image is loaded well, and it seems decompressed well as the console output "Compressed image found ..."

but why can't the kernel mount the file system?

I use the kernel included in redhat edk.

-------------------

Now booting the kernel
ttyS00 at 0x0380 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
eth0: CPM ENET Version 0.2, 00:01:c4:00:00:b1
RAMDISK: Compressed image found at block 0
Kernel panic: VFS: Unable to mount root fs on 01:00
Rebooting in 180 seconds..

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
