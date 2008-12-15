Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E76E8DDE9F
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 07:37:03 +1100 (EST)
Message-Id: <636BC2D5-0606-4558-AFEC-436835774867@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20081215054539.2B9B8DDFB4@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 8/16] powerpc/mm: Rename tlb_32.c and tlb_64.c to
	tlb_hash32.c and tlb_hash64.c
Date: Mon, 15 Dec 2008 14:36:58 -0600
References: <20081215054539.2B9B8DDFB4@ozlabs.org>
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

> This renames the files to clarify the fact that they are used by
> the hash based family of CPUs (the 603 being an exception in that
> family but is still handled by that code).
>
> This paves the way for the new tlb_nohash.c coming via a subsequent
> patch.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> arch/powerpc/mm/Makefile     |    2
> arch/powerpc/mm/tlb_32.c     |  190  
> --------------------------------------
> arch/powerpc/mm/tlb_64.c     |  211  
> -------------------------------------------
> arch/powerpc/mm/tlb_hash32.c |  190 +++++++++++++++++++++++++++++++++ 
> +++++
> arch/powerpc/mm/tlb_hash64.c |  211 +++++++++++++++++++++++++++++++++ 
> ++++++++++
> 5 files changed, 402 insertions(+), 402 deletions(-)


Acked-by: Kumar Gala <galak@kernel.crashing.org>

(I'm told git-format-patch -M is useful for such patches)

- k
