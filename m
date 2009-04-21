Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A7E3BDDEF3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 19:07:43 +1000 (EST)
Date: Tue, 21 Apr 2009 02:07:34 -0700 (PDT)
Message-Id: <20090421.020734.195609451.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090417220348.GA5429@oksana.dev.rtsoft.ru>
References: <20090417220348.GA5429@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, leoli@freescale.com, afleming@freescale.com,
	Joakim.Tjernlund@transmode.se, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Sat, 18 Apr 2009 02:03:48 +0400

> This will make the system alot more responsive while ping flooding the
> ucc_geth ethernet interface.
> 
> Also set NAPI weight to 64 as this is a common value.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied to net-next-2.6, thank you.
