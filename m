Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6E5F5DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 08:39:52 +1100 (EST)
Date: Wed, 25 Mar 2009 14:39:39 -0700 (PDT)
Message-Id: <20090325.143939.207077477.davem@davemloft.net>
To: joakim.tjernlund@transmode.se
Subject: Re: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1237987849.2194.9.camel@gentoo-jocke.transmode.se>
References: <1237987849.2194.9.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, leoli@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 25 Mar 2009 14:30:49 +0100

> >From 1c2f23b1f37f4818c0fd0217b93eb38ab6564840 Mon Sep 17 00:00:00 2001
> From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Date: Tue, 24 Mar 2009 10:19:27 +0100
> Subject: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context.
>  Also increase NAPI weight somewhat.
>  This will make the system alot more responsive while
>  ping flooding the ucc_geth ethernet interaface.
> 
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

The weight is not for the sake of your device, it's for
the sake of fairness with others.

Please just use 64, like every other driver does.

I'm not applying this.
