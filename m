Date: Fri, 4 Jun 2004 12:35:30 -0400 (EDT)
From: Sharad Gupta <sharad@buckeye.ece.drexel.edu>
To: PowerPC Linux Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: initrd & root fs
Message-ID: <Pine.GSO.4.58.0406041221250.19526@buckeye.ece.drexel.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Friends,

I am in the process of putting together a target system with PPC7455 on a
custom board. Right now, I only have serial port, 8 MB of on-board AMD
flash, flash card through Xilinx System ACE, and 512 MB SDRAM. I can load
the linux image & initrd to the flash or directly to the RAM through
BDI2000.

I have linux running successfully alongwith initial ext2 ramdisk with
busybox (compiled as static with powerpc-linux-gcc). I want to create a
root fs on flash card and be able to either pivot_root to it after initrd
boots up or mount it as root disk without any initrd. Since, I only have
100 MB on flash card, I plan on using uClibc. Now, I have the following
dilemmas :

1.) Is it necessary to cross compile the kernel using uClibc toolchain or
a glibc one is fine ?

2.) If I use initrd with flash card as root fs, do I need to build initrd
as static binary or dynamic one ?

3.) What is the best approach to use given this situation, I havent been
able to put together a stable system. Everytime, I do pivot_root from
busybox (loaded from initrd) to the flash card (built from buildroot from
uClibc), my system hangs after sometime or I see question marks or strange
characters when I do "ls".

Thanks
--Sharad.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
