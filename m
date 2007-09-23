Return-Path: <miroslaw.dach@psi.ch>
Received: from MAILSEND02.psi.ch (mailsend02.psi.ch [129.129.191.54])
	by ozlabs.org (Postfix) with ESMTP id EC9E4DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 23 Sep 2007 23:27:55 +1000 (EST)
Date: Sun, 23 Sep 2007 15:27:52 +0200 (CEST)
From: Miroslaw Dach <miroslaw.dach@psi.ch>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux doesn not boot from u-boot on ML403
Message-ID: <Pine.LNX.4.44.0709231519510.25165-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant,

Thank you very much for your advices which were very valuable for me.

Recently I have followed your advice to move from kernel 2.6.21 to the
higher one in order to have the possibility to boot the kernel from
u-boot. I have copied across from you git tree the latest version of linux
kernel 2.6.23 rc-2.

It compiles successfully with some warnings like below:
  MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x223c): Section mismatch: reference to .init.text:early_init (between 'start_here' and 'initial_mmu')
WARNING: vmlinux.o(.text+0x2254): Section mismatch: reference to .init.text:machine_init (between 'start_here' and 'initial_mmu')
WARNING: vmlinux.o(.text+0x2258): Section mismatch: reference to .init.text:MMU_init (between 'start_here' and 'initial_mmu')
WARNING: vmlinux.o(.text+0x22b2): Section mismatch: reference to .init.text:start_kernel (between 'start_here' and 'initial_mmu')
WARNING: vmlinux.o(.text+0x22b6): Section mismatch: reference to .init.text:start_kernel (between 'start_here' and 'initial_mmu')
   LD      vmlinux


My observation is that the linux 2.6.23 rc-2 is not that stable as 2.6.21.
In most cases It boots successfully (ie. zImage.elf) but occasionally it
fails during booting. It has never occurred with 2.6.21 which I also
copied from your side.

For both kernels I use the same xparamerets_ml403.h file and very similar
.config file

Do you have some idea if it is known problem with booting in 2.6.23 rc-2?  
It of course could be something wrong with my ml403 board but I just
wanted to get your opinion about the stability issue. Maybe it is better
to use 2.6.22?

Second question:

In addition I wanted to ask you about u-boot tree which you have mentioned
in the post on u-boot mailing list. This post was about uart lite for
ml403 in u-boot.

I was not able to find the project which you have mentioned there:
git://git.secretlab.ca/git/u-boot.git

This what interests me in particular concerning u-boot is the uart lite
and temac interfaces from ml403.

Thank you very much in advance for any hint

Best Regards

Mirek
