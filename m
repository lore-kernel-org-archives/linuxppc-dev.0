Message-Id: <5.1.0.14.2.20030117091558.0263dd98@falcon.si.com>
Date: Fri, 17 Jan 2003 09:16:39 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: building lilo, grub or PPCBoot for a custom board
In-Reply-To: <000006FA.C22236@airbus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


OK, everybody together shout "use u-boot" (sourceforge.net).

gvb


At 02:58 PM 1/17/2003 -0500, jean-charles.breuvart@airbus.com wrote:

>Hi !
>
>I' succedded in building denx-eldk from rpm packages on my RedHat 8.0
>(thanks wolfgang !), and then a 1st linux kernel that I'd like to download
>via the VME into the FLash ROM.
>
>So I'm trying to build a cute boot loader (for linux of course !) for my
>custom board :
>
>  - VME64x based
>  - PCC755 without L2 cache
>  - no PCI bus
>  - 2Mo Flash 29DL163 at 0xFFE00000
>  - 128 Mo SDRAM at 0x0000000
>  - a simple UART
>  - some analog I/Os
>
>the UART, VME and Flash drivers source code is ok, but I still have somme
>questions :
>
>  - where and how to introduce the arch dependent source code in the source
>tree of those boot loaders ?
>  - how to configure the Makefile to build a light exe ?
>  - how to configure the linker command file or ld swithes for a particular
>mapping ?
>
>Thanks,
>
>Regards, JC.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
