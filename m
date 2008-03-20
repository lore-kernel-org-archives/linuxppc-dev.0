Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84166DDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 17:55:25 +1100 (EST)
Subject: Re: [PATCH 1/2] [POWERPC] Add PPC4xx L2-cache support (440GX &
	460EX/GT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1205847389-17771-1-git-send-email-sr@denx.de>
References: <1205847389-17771-1-git-send-email-sr@denx.de>
Content-Type: text/plain
Date: Thu, 20 Mar 2008 17:54:52 +1100
Message-Id: <1205996092.26869.420.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-03-18 at 14:36 +0100, Stefan Roese wrote:
> This patch adds support for the 256k L2 cache found on some IBM/AMCC
> 4xx PPC's. It introduces a common 4xx SoC file (sysdev/ppc4xx_soc.c)
> which currently "only" adds the L2 cache init code. Other common 4xx
> stuff can be added later here.
> 
> The L2 cache handling code is just a copy of Eugene's code in arch/ppc
> with small modifications.
> 
> Tested on AMCC Taishan 440GX and Canyonlands 460EX.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>

It's my understanding that on some 44x platforms, the l2 needs to be
explicitely invalidated on DMAs. Do we know more about that ? I think it
depends on something like the number of masters on the PLB4 or so. I
don't remember the details.

Ben.
