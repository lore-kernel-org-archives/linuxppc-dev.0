Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 45997DDE06
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Mar 2009 07:28:24 +1100 (EST)
Date: Sat, 21 Mar 2009 13:28:11 -0700 (PDT)
Message-Id: <20090321.132811.142453736.davem@davemloft.net>
To: galak@kernel.crashing.org
Subject: Re: [PATCH -next] gianfar: Fix build with CONFIG_PM enabled
From: David Miller <davem@davemloft.net>
In-Reply-To: <DA082A7B-8C8A-47A9-9B50-143AF6A27F18@kernel.crashing.org>
References: <20090319151217.GA11465@oksana.dev.rtsoft.ru>
	<DA082A7B-8C8A-47A9-9B50-143AF6A27F18@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, afleming@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 19 Mar 2009 10:16:26 -0500

> 
> On Mar 19, 2009, at 10:12 AM, Anton Vorontsov wrote:
> 
> > commit 4826857f1bf07f9c0f1495e9b05d125552c88a85 ("gianfar: pass the
> > proper dev to DMA ops") introduced this build breakage:
...
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> Acked-by: Kumar Gala <galak@kernel.crashing.org>

Applied, thanks.
