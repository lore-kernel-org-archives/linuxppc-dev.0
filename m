Subject: Linux on Force Computers CPCI-3750
From: luca gambazzi <luca.gambazzi@epfl.ch>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1048949739.5125.126.camel@shampoo.epfl.ch>
Mime-Version: 1.0
Date: 29 Mar 2003 15:55:41 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

As suggested, i've tried to compile the penguingppc.org linux kernel for
my CPCI-3750.

I've got still 2 problems:

with the 2.4 tree (stable and devel) the make znetboot.initrd return an
error here:

powerpc-linux-gcc -D__KERNEL__ -I/usr/local/src/linux-2.4-rsync/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer
-I/usr/local/src/linux-2.4-rsync/arch/ppc -fsigned-char -msoft-float
-pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -nostdinc
-iwithprefix include -DKBUILD_BASENAME=cputable  -c -o cputable.o
cputable.c
cputable.c:179: `CPU_FTR_HAS_HIGH_BATS' undeclared here (not in a
function)
[...]

in the 2.5 tree the compile works fine, but when boots i've got this
error:

[...]
RAMDISK: Compressed image found at block 0
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C00154D4 LR: C000C9D0 SP: C0ACBD50 REGS: c0acbca0 TRAP: 0301    Not
tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000000, DSISR: 42000000
TASK = c0acc060[1] 'swapper' Last syscall: 6
GPR00: 00001032 C0ACBD50 C0ACC060 C01B7C0C C0ACBD58 00000000 C0ACBD68
0000000A
GPR08: FFFFFFFF C0ACBD64 00000000 00009032 2010C048
Call trace: [c008c528]  [c008c788]  [c0079660]  [c00fd258]  [c0048bd8]
[c0048af0]  [c004723c]  [c0047300]  [c00077d4]  [c000a544]  [c01cba04
Kernel panic: Attempted to kill init!

i'm not a CS student,... just an electronic student. so i don't
understand what to do to resolve this error. I've used a working ramdisk
image from timesys.com, so the error is in my kernel.

i've tryed to incrase the ramdisk dimension (the ramdisk i use is 8192)
but still the same problem

can anybody give me an advice?
here can you find a boot log http://lsa1pc32.epfl.ch/~gamba/boot.txt
thanks a lot
luca gambazzi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
