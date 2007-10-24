Return-Path: <timur@freescale.com>
Message-ID: <471F9FE5.7040808@freescale.com>
Date: Wed, 24 Oct 2007 14:41:25 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>	
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>	
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>	
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>	
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>	
	<fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>	
	<9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>	
	<fa686aa40710240938l5b8c30b9qe538cc641df5e61b@mail.gmail.com>	
	<9e4733910710241001g165e7aeatdc92096544fbeb60@mail.gmail.com>	
	<471F7D28.6050107@freescale.com>
	<9e4733910710241231h9427223kbfcc23be2e111194@mail.gmail.com>
In-Reply-To: <9e4733910710241231h9427223kbfcc23be2e111194@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> Why are you using a vendor named directory? I don't believe vendor
> named directories are used anywhere in the kernel. The directories are
> always named after the platform or architecture. Vendor directories
> end up in a big mess if Freescale decides to sell a CPU to someone
> else.

Two reasons:

1) The sound/soc directory already has names like "at91" and "pxa", so I thought 
"fsl" is appropriate.

2) There may not be any directories named "fsl", but there are plenty of files 
with that name:

./arch/powerpc/boot/fsl-soc.c
./arch/powerpc/boot/fsl-soc.h
./arch/powerpc/boot/fsl-soc.o
./arch/powerpc/mm/fsl_booke_mmu.c
./arch/powerpc/platforms/fsl_uli1575.c
./arch/powerpc/sysdev/fsl_pci.c
./arch/powerpc/sysdev/fsl_pci.h
./arch/powerpc/sysdev/fsl_soc.c
./arch/powerpc/sysdev/fsl_soc.h
./arch/powerpc/sysdev/fsl_soc.o
./arch/ppc/mm/fsl_booke_mmu.c
./drivers/usb/gadget/fsl_usb2_udc.c
./drivers/usb/gadget/fsl_usb2_udc.h
./include/linux/fsl_devices.h
./include/config/fsl

Having said all that, if you really think sound/soc/powerpc is better than 
sound/soc/fsl, I won't complain.
