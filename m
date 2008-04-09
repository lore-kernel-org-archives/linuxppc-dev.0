Return-Path: <sam.d.karp@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id BBA74DE0DE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Apr 2008 06:10:39 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2819780pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 09 Apr 2008 13:10:33 -0700 (PDT)
Message-ID: <800687fe0804091310t61cedeccpcee0d9384fbd18ed@mail.gmail.com>
Date: Wed, 9 Apr 2008 15:10:33 -0500
From: "Sam Karp" <sam.d.karp@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel 2.6.23 Error with make bzImage
In-Reply-To: <800687fe0804071536t1f94e1a0x793bd39836dc09d2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <800687fe0804071536t1f94e1a0x793bd39836dc09d2@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hey all,
I've been looking through the archives for a ramdisk.image.gz for a
ppc (ml403) but most of the links are broken.  Does anyone have a
working link to one that I could use?

Thanks,
Sam

On 4/7/08, Sam Karp <sam.d.karp@gmail.com> wrote:
> I've been trying to build the linux 2.6.23 kernel for the PPC405 on the
> xilinx ml403.  I copied over my xparameters.h and xparameters_ml40x.h files
> and added the following options through menuconfig.
> Enable loadable module support: DISABLE
> Processor:
>
>    - Type 40x
>    - Math emulation: ENABLE
>    - IBM 40x options:
>       - Machine Type: "Xilinx-ML403"
>
> Platform options:
>
>    - Kernel command line: "console=ttyUL0 root=/dev/ram"
>
> Bus options:
>
>    - PCI support: DISABLE
>    - PCCARD (PCMCIA/CardBus) support:
>       - PCCARD (PCMCIA/CardBus) support: DISABLE
>
> Drivers
>
>    - Block Devices:
>       - Xilinx SystemACE support: ENABLE
>    - Character devices:
>       - Serial drivers:
>          - Xilinx uartlite serial port support: ENABLE
>          - Support for console on Xilinx uartlite serial port:
>          ENABLE
>
> I then ran make bzImage and got the following errors.  I'm guessing there
> are two options I chose that conflict.  Any insight?
>
>  CC arch/powerpc/kernel/swsusp.o
> arch/powerpc/kernel/swsusp.c 19 error: redefinition of
> 'save_processor_state'
> include/asm/suspend.h 7  : previous definition of 'save_processor_state' was
> here
>  arch/powerpc/kernel/swsusp.c 35 error: redefinition of
> 'restore_processor_state'
> include/asm/suspend.h 11  : previous definition of 'restore_processor_state'
> was here
>
> Thanks,
> Sam
>
