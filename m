Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8CAF2DDE32
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 09:38:11 +1000 (EST)
Subject: Re: [PATCH] Sam440ep support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 06 May 2008 09:38:02 +1000
Message-Id: <1210030682.21644.116.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Giuseppe Coviello <cjg@cruxppc.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-05-05 at 13:27 -0500, Kumar Gala wrote:
> On May 5, 2008, at 1:23 PM, Giuseppe Coviello wrote:
> 
> > This patch adds the support for the sam440ep board.
> >
> > arch/powerpc/boot/Makefile                  |    5 +-
> > arch/powerpc/boot/cuboot-sam440ep.c         |   35 +
> > arch/powerpc/boot/dts/sam440ep.dts          |  292 ++++++
> > arch/powerpc/boot/sam440ep.c                |   53 +
> > arch/powerpc/configs/44x/sam440ep_defconfig | 1429 ++++++++++++++++++ 
> > +++++++++
> > arch/powerpc/platforms/44x/Kconfig          |    9 +
> > arch/powerpc/platforms/44x/Makefile         |    1 +
> > arch/powerpc/platforms/44x/sam440ep.c       |   66 ++
> > arch/powerpc/sysdev/Makefile                |    1 +
> > arch/powerpc/sysdev/sam440ep.c              |  112 +++
> > include/asm-powerpc/dma-mapping.h           |   30 +
> > sound/core/memalloc.c                       |   31 +-
> 
> The changes to dma-mapping.h and sound/core/memalloc.c need to be  
> explained and odds are will not go in as is.

They can certainly not be merged in their current form. Guiseppe, what
is the underlying problem, can you describe it in details ?

Ben.
