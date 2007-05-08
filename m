Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2B855DDE05
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 06:30:58 +1000 (EST)
Message-ID: <4640DDD8.4040001@freescale.com>
Date: Tue, 08 May 2007 15:30:16 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: Current powerpc.git build failures
References: <20070508191758.GA26879@lixom.net>
In-Reply-To: <20070508191758.GA26879@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com, paulus@samba.org, arnd@ardnb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:

> powerpc.mpc8641_hpcn_defconfig:
> In file included from include/asm-generic/pgtable-nopmd.h:6,
>                  from include/asm/pgtable-ppc32.h:4,
>                  from include/asm/pgtable.h:8,
>                  from arch/powerpc/platforms/86xx/mpc86xx_smp.c:18:
> include/asm-generic/pgtable-nopud.h:13: error: expected specifier-qualifier-list before 'pgd_t'

This must have occurred in the past 24 hours because I built the latest 8641 yesterday 
morning and it worked fine.  mpc86xx_smp.c has not changed since February, so I'm guessing 
that some header file that mpc86xx_smp.c includes no longer includes some other header.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
