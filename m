Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D24AEDE057
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 14:17:04 +1000 (EST)
Date: Sun, 17 May 2009 21:16:58 -0700 (PDT)
Message-Id: <20090517.211658.245399748.davem@davemloft.net>
To: buytenh@wantstofly.org
Subject: Re: [PATCH] mv643xx_eth: fix PPC DMA breakage
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090515235330.GC1727@mail.wantstofly.org>
References: <20090515183924.GA29279@iram.es>
	<20090515235330.GC1727@mail.wantstofly.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, pacman@kosh.dhis.org,
	tbm@cyrius.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Sat, 16 May 2009 01:53:30 +0200

> On Fri, May 15, 2009 at 08:39:24PM +0200, Gabriel Paubert wrote:
> 
>> After 2.6.29, PPC no more admits passing NULL to the dev parameter of
>> the DMA API. The result is a BUG followed by solid lock-up when the 
>> mv643xx_eth driver brings an interface up. The following patch makes 
>> the driver work on my Pegasos again; it is mostly a search and replace 
>> of NULL by mp->dev->dev.parent in dma allocation/freeing/mapping/unmapping
>> functions.
>> 
>> Signed-off-by: Gabriel Paubert <paubert@iram.es>
> 
> Acked-by: Lennert Buytenhek <buytenh@marvell.com>

Applied, thanks everyone.
