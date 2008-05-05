Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EFAE1DE131
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 04:27:42 +1000 (EST)
Message-Id: <6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Giuseppe Coviello" <cjg@cruxppc.org>
In-Reply-To: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Sam440ep support
Date: Mon, 5 May 2008 13:27:28 -0500
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 5, 2008, at 1:23 PM, Giuseppe Coviello wrote:

> This patch adds the support for the sam440ep board.
>
> arch/powerpc/boot/Makefile                  |    5 +-
> arch/powerpc/boot/cuboot-sam440ep.c         |   35 +
> arch/powerpc/boot/dts/sam440ep.dts          |  292 ++++++
> arch/powerpc/boot/sam440ep.c                |   53 +
> arch/powerpc/configs/44x/sam440ep_defconfig | 1429 ++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/44x/Kconfig          |    9 +
> arch/powerpc/platforms/44x/Makefile         |    1 +
> arch/powerpc/platforms/44x/sam440ep.c       |   66 ++
> arch/powerpc/sysdev/Makefile                |    1 +
> arch/powerpc/sysdev/sam440ep.c              |  112 +++
> include/asm-powerpc/dma-mapping.h           |   30 +
> sound/core/memalloc.c                       |   31 +-

The changes to dma-mapping.h and sound/core/memalloc.c need to be  
explained and odds are will not go in as is.

Also, the .dts should be v1 format.

- k
