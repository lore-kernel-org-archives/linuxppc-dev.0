From: "Stefan Balcerczak" <Stefan.Balcerczak@marconi.com>
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <80256A37.004287C6.00@marconicomms.com>
Date: Mon, 23 Apr 2001 14:09:43 +0200
Subject: unable to mount root fs on 01:00
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I'm totally new to embedded linux, but have some expierence with i386-versions
of linux.
I'm working with an MPC860 on a MBX860-004 board.

I already managed to get a nfs-version of embedded linux (hardhat) to run. But I
have trouble to build linux with initrd - the start-sequence shows as follows:


====================================================================================
[snip]

Linux/PPC load: root=/dev/ram0
Uncompressing Linux... done.
Now booting the kernel
Linux version 2.2.14 (bal2bk@bkrfs31) (gcc version 2.95.2 19991024 (release)) #1
5 Mon Apr 23 09:39:59 MEST 2001
Boot arguments: root=/dev/ram0
Decrementer Frequency: 2500000
Calibrating delay loop... 39.73 BogoMIPS
Memory: 13308k available (664k kernel code, 448k data, 36k init) [c0000000,c1000
000]
Dentry hash table entries: 2048 (order 2, 16k)
Buffer cache hash table entries: 16384 (order 4, 64k)
Page cache hash table entries: 4096 (order 2, 16k)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 16384 bhash 16384)
Starting kswapd v 1.5
CPM UART driver version 0.03-wd
ttyS0 on SMC1 at 0x0280, BRG1
ttyS1 on SMC2 at 0x0380, BRG2
ttyS2 on SCC2 at 0x0100, BRG3
ttyS3 on SCC3 at 0x0200, BRG4
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
eth0: CPM ENET Version 0.2 on SCC1, 08:00:3e:26:29:a4
IP-Config: Incomplete network configuration information.
dev_close: bug eth0 still running
RAMDISK: Compressed image found at block 0
Kernel panic: VFS: Unable to mount root fs on 01:00
Rebooting in 180 seconds..
====================================================================================


So I have 2 problems:

1) How do I pass the correct ip-config?

2) why can't linux mount the root fs?

I already checked the docu and the older postings and tried everything I found
with no success:

bootargs: - root=/dev/ram rw
          - root=/dev/ram0 rw
          - init=/dev/ram
          - init=/dev/ram0
          - console=/dev/ttyS0

The ramdisk is smaller than 4096 kb so there shouldn't be any problem ...

With best regards,

Stefan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
