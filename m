Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <012801c388c5$f4378540$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Queston about Walnut
Date: Thu, 2 Oct 2003 17:17:00 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

    I get a IBM 405 GP evaluation board recently. After I compile the
toolchain and kernel 2.4.22 using the crosstools. I try to boot the kernel
on the board by u-boot. I follow the instruction of uboot to create a uImage
as follows:

    powerpc-405-linux-gnu-objcopy -O binary -R .note -R .comment -S vmlinux
linux.bin
    gzip -9  linux.bin
    ./mkimage -A ppc -O linux -T kernel -C gzip -a 0x00400000 -e
0x00400000 -n "test" -d linux.bin.gz uImage

    and load the image by tftpboot. But after I type bootm, only the
following is displayed and the whole system hangs:

    ## Booting image at 00400000 ...
   Image Name:   test
   Created:      2003-10-02   8:51:50 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    612743 Bytes = 598.4 kB
   Load Address: 00400000
   Entry Point:  00400000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   <Hangs afterwards...>

    I haven't modified any source yet. I don't know even it is needed.
    Could anyone kindly tell me what's wrong about my steps? Thanks so much.

Regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
