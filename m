Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2047FDDE3A
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 18:43:36 +1000 (EST)
Date: Wed, 04 Apr 2007 01:43:30 -0700 (PDT)
Message-Id: <20070404.014330.91315500.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070404083803.GA13134@flint.arm.linux.org.uk>
References: <1175666635.2932.17.camel@shinybook.infradead.org>
	<20070404.011208.120446173.davem@davemloft.net>
	<20070404083803.GA13134@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Wed, 4 Apr 2007 09:38:03 +0100

> However, despite people pressing for it, there's yet to be a *sane*
> *technical* *solution* to the problem.  All I've seen so far is one
> bad hack.

Well the "bad hack" we use on sparc gives usable serial ports,
properly ordered and using /dev/ttyS0, with a proper matching
console selection.
