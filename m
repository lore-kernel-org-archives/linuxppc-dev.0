Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 95B11DDECB
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 14:01:54 +1000 (EST)
Date: Thu, 19 Jul 2007 21:01:53 -0700 (PDT)
Message-Id: <20070719.210153.07642381.davem@davemloft.net>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH 11/12] Create linux/of_platorm.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070720011925.f51f998a.sfr@canb.auug.org.au>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
	<20070720011925.f51f998a.sfr@canb.auug.org.au>
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
Date: Fri, 20 Jul 2007 01:19:25 +1000

> Move common stuff from asm-powerpc/of_platform.h to here and
> move the common bits from asm-sparc*/of_device.h here as well.
> 
> Create asm-sparc*/of_platform.h and move appropriate parts of
> of_device.h to them.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David S. Miller <davem@davemloft.net>

Tested on SunBlade1500.
