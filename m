Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6E574DF154
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:21:35 +1000 (EST)
Date: Thu, 21 Aug 2008 14:21:34 -0700 (PDT)
Message-Id: <20080821.142134.127315039.davem@davemloft.net>
To: scottwood@freescale.com
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080821163256.GC15669@ld0162-tx32.am.freescale.net>
References: <20080821.001012.265401427.davem@davemloft.net>
	<20080821163256.GC15669@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>
Date: Thu, 21 Aug 2008 11:32:56 -0500

> On Thu, Aug 21, 2008 at 12:10:12AM -0700, David Miller wrote:
> > 2) When CONFIG_SPARC, shift the device address down by one bit before
> >    giving it to the Linux I2C layer.
> 
> Maybe we should distinguish by the type of I2C bus node instead.

How so?  If a Sparc and a PowerPC system use similar I2C
controllers, we risk double matches.

If you guys created this format in your compressed openfirmware
trees, is it possible for you to "fix" it to match what Sparc
systems following the proper bindings do?

This way we won't need any of these ifdefs at all.

Don't PowerMACs and such have I2C controllers and devices?
How do they encode these I2C client device reg properties?
