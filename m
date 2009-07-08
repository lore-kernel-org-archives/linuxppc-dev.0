Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 47FE6B708D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 12:23:05 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 0C4C0DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 12:23:05 +1000 (EST)
Date: Tue, 07 Jul 2009 19:23:07 -0700 (PDT)
Message-Id: <20090707.192307.222215206.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] ucc_geth: Add support for skb recycling
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090707183842.GA8425@oksana.dev.rtsoft.ru>
References: <20090707183842.GA8425@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, leoli@freescale.com, afleming@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Tue, 7 Jul 2009 22:38:42 +0400

> We can reclaim transmitted skbs to use in the receive path, so-called
> skb recycling support.
> 
> Also reorder ucc_geth_poll() steps, so that we'll clean tx ring firstly,
> thus maybe reclaim some skbs for rx.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied to net-next-2.6
