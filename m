Message-ID: <008c01c04af9$80dca5b0$69f001dc@r44089-d1.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: decompress the kenerl image for MPC8260ADS-L2C board
Date: Fri, 10 Nov 2000 17:35:02 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I built the linux-2.4.0-test2 kernel on x86 platform,
The powerpc-linux-gcc version is 2.95.2,
the target board is MPC8260ADS-L2C board from Motorola.
After I download the kennel image (zImage.initrd)
using the EST tools visionICE to the target,
The boot code can not correctly decompress the kernel.

Before boot/head_8260.S call decompress_kernel(),
the compressed kernel image in memory is right, ( I upload it
from target to my host, it's same as the file vmlinux.gz),
but after it call the decompress_kernel() function,
the value of address 0,4,8... all are filled with 0.
It seems that the coff/zlib.c can not correctly decompress the
kernel image.
I have no any knowledge about gnuzip.

Any suggestion?
Thanks.


loaded at:     00400000 005C1270
board data at: 0001126C 00011290
relocated to:  00200100 00200124
zimage at:     00409D70 0047A61F
initrd at:     0047A61F 005BCBF8
avail ram:     005BD000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
