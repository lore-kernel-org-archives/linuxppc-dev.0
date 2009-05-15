Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (xi.wantstofly.org [80.101.37.227])
	by ozlabs.org (Postfix) with ESMTP id 3DED0DE127
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 10:21:01 +1000 (EST)
Date: Sat, 16 May 2009 01:53:30 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH] mv643xx_eth: fix PPC DMA breakage
Message-ID: <20090515235330.GC1727@mail.wantstofly.org>
References: <20090515183924.GA29279@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090515183924.GA29279@iram.es>
Cc: tbm@cyrius.com, LinuxPPC <linuxppc-dev@ozlabs.org>, pacman@kosh.dhis.org,
	netdev@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 15, 2009 at 08:39:24PM +0200, Gabriel Paubert wrote:

> After 2.6.29, PPC no more admits passing NULL to the dev parameter of
> the DMA API. The result is a BUG followed by solid lock-up when the 
> mv643xx_eth driver brings an interface up. The following patch makes 
> the driver work on my Pegasos again; it is mostly a search and replace 
> of NULL by mp->dev->dev.parent in dma allocation/freeing/mapping/unmapping
> functions.
> 
> Signed-off-by: Gabriel Paubert <paubert@iram.es>

Acked-by: Lennert Buytenhek <buytenh@marvell.com>

Thanks for testing!
