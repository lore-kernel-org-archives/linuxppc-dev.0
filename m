Message-ID: <20000310145804.29010.qmail@web216.mail.yahoo.com>
Date: Fri, 10 Mar 2000 06:58:04 -0800 (PST)
From: Sebastien Articlaux <sebastien_articlaux@yahoo.com>
Subject: Problem with RAMDISK "No init found"
To: embedded linuxppc <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1025202362-952700284=:25770"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--0-1025202362-952700284=:25770
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I've now Linux booting onto our custom chip,MPC 860,
64M SDRAM, 4M Flash, 1 FPGA&32M DRAM

I've got this message
kmod: failed to exec /sbin/modprobe -s -k
char-major-5, errno = 2

I don't what is modprobe.
I think I must recreate my RAMDIK whith modprobe in
it...

What do you think?


Sebastien ARTICLAUX

--0-1025202362-952700284=:25770
Content-Type: text/plain; name="log.txt"
Content-Description: log.txt
Content-Disposition: inline; filename="log.txt"

Loading Linux...

RAM size:      04000000
loaded at:     08000000 080091E8
relocated to:  00100000 001091E8
board data at: 007FFDC0 007FFE00
relocated to:  007FFDC0 007FFE00
Boot args at:  007FFE00 00800000
initrd at:     0804213C 08100391
relocated to:  00F41000 00FFF255
avail ram:     0010A000 00F41000

Linux/PPC load: root=/dev/ram
Uncompressing Linux... done.
Now booting the kernel
Linux version 2.2.10 (root@conf625) (gcc version egcs-2.91.66 19990314 (egcs-1.0
Boot arguments: root=/dev/ram
time_init: decrementer frequency = 93750000/60
Calibrating delay loop... 24.88 BogoMIPS
Memory: 63384k available (428k kernel code, 932k data, 28k init) [c0000000,c400]
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
Starting kswapd v 1.5
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SCC
ttyS02 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
bit_width: 2, chip_cfg: 1
Found 2x16bit 4Mbyte CFI flash device of type AMD/Fujitsu standard at 8000000
registered flash device /dev/flash0
RAM disk driver initialized:  16 RAM disks of 4096K size
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 28k init
kmod: failed to exec /sbin/modprobe -s -k char-major-5, errno = 2
SASH terminated
Kernel panic: No init found.  Try passing init= option to kernel.
Rebooting in 180 seconds..
--0-1025202362-952700284=:25770--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
