Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "okisoftxman" <okisoftxman@hotmail.com>
To: "Callebaut, Benoit" <benoit.callebaut@barco.com>
Cc: "linux-emb" <linuxppc-embedded@lists.linuxppc.org>
Subject: why can't boot linux?
Date: Wed, 26 Feb 2003 16:48:17 +0900
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <OE64gR4ktsqHwexHdqK000096f9@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
    I have booting the linux from PPCBOOT on my MBX860 board,but I haven't
successed.Although I do it followed with the README.
1.    Now I find a interesting thing.In linux-2.4.2 ,This file
(arch/ppc/kernel/head_8xx.S) notes these words:
/* MPC8xx
 * This port was done on an MBX board with an 860.  Right now I only
 * support an ELF compressed (zImage) boot from EPPC-Bug because the
 * code there loads up some registers before calling us:
 *   r3: ptr to board info data
 *   r4: initrd_start or if no initrd then 0
 *   r5: initrd_end - unused if r4 is 0
 *   r6: Start of command line string
 *   r7: End of command line string
 *
 * I decided to use conditional compilation instead of checking PVR and
 * adding more processor specific branches around code I don't need.
 * Since this is an embedded processor, I also appreciate any memory
 * savings I can get.
 */.

  Does this mean I can't boot this linux from ppcboot on MBX860 board?


2. And In PPCBOOT's README,also tell me these words:

/*Just make sure your machine specific header file (for instance
include/asm-ppc/tqm8xx.h) includes the same definition of the Board
Information structure as we define in include/ppcboot.h, and make
sure that your definition of IMAP_ADDR uses the same value as your
PPCBoot configuration in CFG_IMMR.*/

(In my case,I think the tqm8xx.h maybe be replaced with
ppcboot/include/asm-ppc/mbx.h)

mbx.h(linux)is not same completely with the
include/asm-ppc/ppcboot.h(ppcboot).
But I find a file named ppcboot.h (linux/include/asm-ppc/ppcboot.h) is
similar to
the ppcboot.h(In ppcboot).

Do I modify these files? And how to do?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
