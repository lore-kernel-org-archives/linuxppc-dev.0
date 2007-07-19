Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D2CC3DDED0
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 09:48:17 +1000 (EST)
Date: Thu, 19 Jul 2007 16:48:16 -0700 (PDT)
Message-Id: <20070719.164816.25912004.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH 02/12] Start split out of common open firmware code
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070720010911.01402add.sfr@canb.auug.org.au>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720010911.01402add.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	wli@holomorphy.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 20 Jul 2007 01:09:11 +1000

> This creates drivers/of/base.c (depending on CONFIG_OF) and puts
> the first trivially common bits from the prom.c files into it.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>

Tested on SunBlade1500.
