Return-Path: <klemen.porenta@siol.net>
Received: from mta2.siol.net (mta2.siol.net [193.189.160.131])
	by ozlabs.org (Postfix) with ESMTP id 6853867CB1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Jul 2005 00:58:38 +1000 (EST)
Received: from [10.10.10.170] (really [10.10.10.180]) by mta1.siol.net
	with SMTP id <20050715133409.GTCT2352.mta1.siol.net@[10.10.10.170]>
	for <linuxppc-embedded@ozlabs.org>; Fri, 15 Jul 2005 15:34:09 +0200
From: Klemen Porenta <klemen.porenta@siol.net>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 15 Jul 2005 15:34:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=8859_2
Message-Id: <20050715133409.GTCT2352.mta1.siol.net@[10.10.10.170]>
Subject: ELDK 3.1.1 and E500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi folks,I have one problem regarding gcc compiler for e500. 

I have compiled u-boot 1.1.2 for my target board ADS8560 with ELDK 3.1.1. If I am correct it is using gcc version 3.3.3.

Everything is compiled ok and if I start u-boot on my target I get program exception (illegal instruction) on stswi instruction. This instruction is defined in Book E bot not implemented in e500 as I read in Freescale documentation. 

This is my gcc call for compiling console.c where I get illegal instruction:
ppc_85xx-gcc -g  -Os   -fPIC -ffixed-r14 -meabi -D__KERNEL__ -DTEXT_BASE=0xfff80000 -I/users/rdhw/kpor/sw/linux/u-boot-1.1.2/include -fno-builtin -ffreestanding -nostdinc -isystem /opt/eldk3.1.1/usr/bin/../lib/gcc-lib/ppc-linux/3.3.3/include -pipe  -DCONFIG_PPC -D__powerpc__ -DCONFIG_MPC85xx -DCONFIG_E500 -ffixed-r2 -ffixed-r29 -Wa,-me500 -msoft-float -DCONFIG_MPC85xx=1 -DCONFIG_MPC8560=1 -DCONFIG_E500=1 -Wall -Wstrict-prototypes -c -o console.o console.c

What am I doing wrong or is this gcc problem?

Thanks in advance, Klemen
