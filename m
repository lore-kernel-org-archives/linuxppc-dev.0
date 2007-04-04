Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E2114DDE47
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:17:34 +1000 (EST)
Date: Tue, 03 Apr 2007 18:17:33 -0700 (PDT)
Message-Id: <20070403.181733.27782389.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1175649192.30879.19.camel@localhost.localdomain>
References: <20070403.170212.02298297.davem@davemloft.net>
	<1175645568.10567.42.camel@shinybook.infradead.org>
	<1175649192.30879.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: paulus@samba.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 04 Apr 2007 11:13:12 +1000

> It worked before the new serial core, we had a "tweak" in the old 8250
> driver to be able to share minors, but that got busted when Russell
> rewrote the whole thing. I remember asking him back when he still was
> the serial maintainer, and he refused to bring back some sharing of
> minors.

Fork the 8250 driver like I did on Sparc so you can get the
dynamic minor behavior back :-))))
