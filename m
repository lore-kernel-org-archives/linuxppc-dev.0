Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82CA8DDEF4
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 09:44:30 +1000 (EST)
Subject: Re: [PATCH] Sam440ep support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20080505195054.172000@gmx.net>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
	<20080505195054.172000@gmx.net>
Content-Type: text/plain
Date: Tue, 06 May 2008 09:44:18 +1000
Message-Id: <1210031058.21644.120.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cjg@cruxppc.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-05-05 at 21:50 +0200, Gerhard Pircher wrote:
> This is a (bad) hack that I also use on the AmigaOne to get the ALSA
> sound
> drivers working with DMA, because ALSA doesn't work with
> dma-noncoherent.c.
> The problem is the "nopage" mechanism, which fails with non coherent
> DMA
> allocations due to their own virtual address space (correct me, if I'm
> wrong).
> 
> See this thread for more info:
> http://readlist.com/lists/vger.kernel.org/linux-kernel/45/226541.html
> 
> This is a general problem that affects all powerpc boards that use
> dma-noncoherent.c with ALSA PCI drivers.

The link above doesn't provide any useful information on the problem and
it contains itself a non working link...

Can somebody explains exactly what's going on ? That shouldn't be hard
to fix. I can't believe the problem has been around for 2 years and
nobody actually bothered fixing it properly.

Send me a sound card that needs that hack and I can take care of it
myself.

Ben.
