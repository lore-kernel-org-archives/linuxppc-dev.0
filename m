Return-Path: <kashiwagi@co-nss.co.jp>
Received: from nssinet2.co-nss.co.jp (nssinet2.co-nss.co.jp [150.96.0.5])
	by ozlabs.org (Postfix) with ESMTP id 3D805DE18A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 17:23:41 +1000 (EST)
MIME-Version: 1.0
Date: Wed, 16 Apr 2008 16:23:32 +0900
Subject: Re: SystemACE on Kernel 2.6
From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
To: rodolfo <rodolfo@lesc.ufc.br>,
	Linuxppc embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <JH200804161623321.302937@co-nss.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
In-Reply-To: <7aa21da00314dfb40c194e38e2488048@lesc.ufc.br>
References: <7aa21da00314dfb40c194e38e2488048@lesc.ufc.br>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

The mark of BRAM is good at bootloop.
Priority is given to specified initial pc if -start_address is specified
by an opt file. Before starting a Linux kernel, can TestApp_Memory or a
TestApp_Peripheral program be started from CF?

The opt file which I am using is as follows.

-jprog
-hw implementation/download.bit
-ace cfboot.ace
-board ml405
-target ppc_hw
-elf zImage.elf
-start_address 0x00400000

Best Regards,

Yoshio Kashiwagi - Nissin Systems

> Hi Grant likely,
> 
> I got kernel 2.6.20 from kernel.org and I want boot it on XUP Virtex 
II Pro
> University board.
> I edited the Makefile putting:
>  ARCH? = ppc
>  CROSS_COMPILE? = ppc_4xx-
> But I can't see anything about SystemACE driver on make menuconfig 
from
> this Kernel. How can I add SystemACE controler?
> 
> I compiled the kernel repeatedly generating a file zImage.elf. I used 
this
> file with the genace.tcl from Xilinx and this opt file:
> -jprog
> -board user
> -target ppc_hw
> -hw implementation/download.bit
> -elf zImage.elf
> -configdevice devicenr 1 idcode 0x1127e093 irlength 14 partname 
xc2vp30
> -debugdevice devicenr 1 cpunr 1
> -ace system.ace
> 
> to generated ace file and put it in FAT16 partition of CF card, like a 
lot
> of references in web. But it doesn't works!
> Which IP cores must be present in my project of the EDK?
> Still speaking in the EDK Did i have to mark bram with ppc_405_0_
bootloop? 
> Did I have to mark bram whit any software project?
> 
> My work in with Linux on Virtex don't work. I am almost dropping...
> 
> Thanks!!
