Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8E4F4DDFBD
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 07:49:17 +1100 (EST)
Date: Fri, 13 Mar 2009 13:49:03 -0700 (PDT)
Message-Id: <20090313.134903.259220375.davem@davemloft.net>
To: felix@embedded-sol.com
Subject: Re: RX problem in ibm_newemac driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <49B77CBF.6070005@embedded-sol.com>
References: <49B6FA3B.8030509@embedded-sol.com>
	<1236730894.7086.29.camel@pasglop>
	<49B77CBF.6070005@embedded-sol.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Felix Radensky <felix@embedded-sol.com>
Date: Wed, 11 Mar 2009 10:56:31 +0200

> Benjamin Herrenschmidt wrote:
> > emac: Fix clock control for 405EX and 405EXr chips
> >
> > The EMAC variant in the 405EX and 405EXr chips needs the "440EP" type clock
> > control workaround to avoid lockups of the Rx side during reset.
> >
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
 ...
> This patch fixes a problem for me. Thank you very much for a quick fix.

Patch applied, thanks everyone.
