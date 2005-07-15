Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 6185E67CDE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Jul 2005 01:01:48 +1000 (EST)
In-Reply-To: <20050715133409.GTCT2352.mta1.siol.net@[10.10.10.170]>
References: <20050715133409.GTCT2352.mta1.siol.net@[10.10.10.170]>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E063F9AB-2E8C-492A-8F50-AB52470D837D@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 15 Jul 2005 10:01:52 -0500
To: Klemen Porenta <klemen.porenta@siol.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK 3.1.1 and E500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If you add a -mno-string to the compile line that should help

- kumar

On Jul 15, 2005, at 8:34 AM, Klemen Porenta wrote:
>
> Hi folks,I have one problem regarding gcc compiler for e500.
>
> I have compiled u-boot 1.1.2 for my target board ADS8560 with ELDK  
> 3.1.1. If I am correct it is using gcc version 3.3.3.
>
> Everything is compiled ok and if I start u-boot on my target I get  
> program exception (illegal instruction) on stswi instruction. This  
> instruction is defined in Book E bot not implemented in e500 as I  
> read in Freescale documentation.
>
> This is my gcc call for compiling console.c where I get illegal  
> instruction:
> ppc_85xx-gcc -g  -Os   -fPIC -ffixed-r14 -meabi -D__KERNEL__ - 
> DTEXT_BASE=0xfff80000 -I/users/rdhw/kpor/sw/linux/u-boot-1.1.2/ 
> include -fno-builtin -ffreestanding -nostdinc -isystem /opt/ 
> eldk3.1.1/usr/bin/../lib/gcc-lib/ppc-linux/3.3.3/include -pipe  - 
> DCONFIG_PPC -D__powerpc__ -DCONFIG_MPC85xx -DCONFIG_E500 -ffixed-r2  
> -ffixed-r29 -Wa,-me500 -msoft-float -DCONFIG_MPC85xx=1 - 
> DCONFIG_MPC8560=1 -DCONFIG_E500=1 -Wall -Wstrict-prototypes -c -o  
> console.o console.c
>
> What am I doing wrong or is this gcc problem?
>
> Thanks in advance, Klemen
>
>
>
