Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 42458B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 05:19:32 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 01485DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 05:19:31 +1000 (EST)
Date: Fri, 11 Sep 2009 12:19:43 -0700 (PDT)
Message-Id: <20090911.121943.267405662.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 1/3] phy/marvell: Make non-aneg speed/duplex forcing
	work for 88E1111 PHYs
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090910020130.GA31083@oksana.dev.rtsoft.ru>
References: <20090910020130.GA31083@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, afleming@freescale.com,
	timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Thu, 10 Sep 2009 06:01:30 +0400

> According to specs, when auto-negotiation is disabled, Marvell PHYs need
> a software reset after changing speed/duplex forcing bits. Otherwise,
> the modified bits have no effect.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied.
