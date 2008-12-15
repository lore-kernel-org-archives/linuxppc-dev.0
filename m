Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B3630DDF63
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 07:30:26 +1100 (EST)
Message-Id: <E9C9C9BC-78A3-4C83-B915-25CCF19F9AF2@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20081215054523.2D75DDDFB0@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 5/16] powerpc/mm: Add local_flush_tlb_mm() to SW loaded
	TLB implementations
Date: Mon, 15 Dec 2008 14:30:20 -0600
References: <20081215054523.2D75DDDFB0@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 14, 2008, at 11:44 PM, Benjamin Herrenschmidt wrote:

> This adds a local_flush_tlb_mm() call as a pre-requisite for some
> SMP work for BookE processors
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> arch/powerpc/include/asm/tlbflush.h |    5 +++++
> 1 file changed, 5 insertions(+)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
