Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0D3296891D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jan 2006 20:49:24 +1100 (EST)
Date: Fri, 20 Jan 2006 01:43:26 -0800 (PST)
Message-Id: <20060120.014326.99470463.davem@davemloft.net>
To: mikpe@csd.uu.se
Subject: Re: [PATCH] x_tables: fix alignment on [at least] ppc32
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17360.44337.425946.347577@alkaid.it.uu.se>
References: <20060120004512.GT4603@sunbeam.de.gnumonks.org>
	<20060119.165635.104653932.davem@davemloft.net>
	<17360.44337.425946.347577@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: laforge@netfilter.org, linuxppc-dev@ozlabs.org,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mikael Pettersson <mikpe@csd.uu.se>
Date: Fri, 20 Jan 2006 10:28:17 +0100

> ACK. Both Harald's patch and DaveM's simplification of it
> (simply s/void */u_int64_t/g in XT_ALIGN()) fix the iptables
> problems on my ppc32 box.

Thanks for testing.
