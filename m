Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53B5ADE1C5
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 06:52:42 +1100 (EST)
Subject: Re: [POWERPC 10/18] Remove bogus comment in
	dma_direct_alloc_coherent()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: arnd@arndb.de
In-Reply-To: <20071218175105.491157000@arndb.de>
References: <20071218174852.112644000@arndb.de>
	<20071218175105.491157000@arndb.de>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 06:52:26 +1100
Message-Id: <1198007546.18908.12.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-12-18 at 18:49 +0100, arnd@arndb.de wrote:
> plain text document attachment
> (0020-Remove-bogus-comment-in-dma_direct_alloc_coherent.patch)
> Since commit c80d9133e99de1af607314107910a2a1645efb17 (Make direct DMA use
> node local allocations) went in this comment makes no sense.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Ack.

>  arch/powerpc/kernel/dma_64.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> Index: linux-2.6-new/arch/powerpc/kernel/dma_64.c
> ===================================================================
> --- linux-2.6-new.orig/arch/powerpc/kernel/dma_64.c
> +++ linux-2.6-new/arch/powerpc/kernel/dma_64.c
> @@ -137,7 +137,6 @@ static void *dma_direct_alloc_coherent(s
>  	void *ret;
>  	int node = dev->archdata.numa_node;
>  
> -	/* TODO: Maybe use the numa node here too ? */
>  	page = alloc_pages_node(node, flag, get_order(size));
>  	if (page == NULL)
>  		return NULL;
> 
