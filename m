Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5FD15DDE20
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 09:33:08 +1100 (EST)
Message-ID: <493DA081.8010205@freescale.com>
Date: Mon, 08 Dec 2008 16:32:33 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 9/9] powerpc: Add SMP support to no-hash TLB handling
References: <20081208054144.503C7DDE2A@ozlabs.org>
In-Reply-To: <20081208054144.503C7DDE2A@ozlabs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Index: linux-work/arch/powerpc/mm/tlb_nohash.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/powerpc/mm/tlb_nohash.c	2008-12-08 16:21:24.000000000 +1100
[snip]
> +#include <asm/spinlock.h>

Needs to be linux/spinlock.h, or UP won't build.

-Scott
