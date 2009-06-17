Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 59540B71BC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 11:09:55 +1000 (EST)
Subject: Re: PowerPC PCI DMA issues (prefetch/coherency?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090617093654B.fujita.tomonori@lab.ntt.co.jp>
References: <4A37DB0F.7060801@freescale.com>
	<200906162002.12376.arnd@arndb.de> <1245197925.21602.0.camel@pasglop>
	<20090617093654B.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain
Date: Wed, 17 Jun 2009 11:07:30 +1000
Message-Id: <1245200850.21602.1.camel@pasglop>
Mime-Version: 1.0
Cc: scottwood@freescale.com, chris.pringle@oxtel.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-17 at 09:37 +0900, FUJITA Tomonori wrote:
> 
> dma_cache_sync is supposed to be used only with the buffers that
> dma_alloc_noncoherent() returns. On architecutures that maps
> dma_alloc_noncoherent to dma_alloc_coherent, dma_cache_sync() is
> supposed to be NOP.
> 
Or at least a sync() on powerpc but yeah, I see. We should probably do
that.

Cheers,
Ben.
