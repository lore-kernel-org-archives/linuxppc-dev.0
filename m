Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 68E1967A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Mar 2005 03:37:33 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 1 Mar 2005 17:37:22 +0100
References: <46110262C7A0BF418DE9C9A5BD73F92807F2F94C@cceexc23.americas.cpqcorp.net>
In-Reply-To: <46110262C7A0BF418DE9C9A5BD73F92807F2F94C@cceexc23.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503011737.22205.g.jaeger@sysgo.com>
Subject: Re: Building a Kernel for the AMCC PPC440EP Bamboo Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Tuesday 01 March 2005 17:14, Zeighami, Roy wrote:
> Hello...
> 
> I am trying to build a kernel image for the AMCC Bamboo PPC440EP board.
> 
> My colleague downloaded a preview kit from MontaVista and that worked.
> 
> However, I am trying to build a toolchain using crosstool and create a
> 2.6.x kernel image.  However, when I type:
> 
> "make ARCH=ppc CROSS_COMPILE=powerpc-440-linux-gnu- menuconfig"
> 
> When I select 44x as the CPU type, I don't see "Bamboo" under machine
> type.  

This won't work, as Bamboo BSP stuff is currently not added.

> Also, I tried building a 2.6.8 kernel image  with Ebony but I can't get
> a successful build.
> 
> I get the following errors:
> 
> drivers/built-in.o(.text+0x3c7ec): In function
> `floppy_release_irq_and_dma':
> : undefined reference to `free_dma'
> drivers/built-in.o(.text+0x3dc14): In function
> `floppy_grab_irq_and_dma':
> : undefined reference to `request_dma'
> drivers/built-in.o(.text+0x3dddc): In function
> `floppy_grab_irq_and_dma':
> : undefined reference to `free_dma'
> make: *** [.tmp_vmlinux1] Error 1

> However, the crosstool web site says that the following combo should
> build: gcc-3.4.2, glibc-2.3.3, binutils-2.15, linux-2.6.8
> 
> Any suggestions?

try to use ebony_defconfig

> Also, if the kernel source provided by Monta Vista is some special
> branch that isn't merged to kernel.org, does anyone know how to get the
> latest source from Monta Vista?

guess you should ask AMCC or MontaVista directly - or extract the 
stuff from the sources you already got from the preview kit.

Ciao,
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
