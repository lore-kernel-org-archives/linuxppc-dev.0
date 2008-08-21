Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2DB45DF8D8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:45:47 +1000 (EST)
Date: Thu, 21 Aug 2008 14:45:45 -0700 (PDT)
Message-Id: <20080821.144545.54542588.davem@davemloft.net>
To: scottwood@freescale.com
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <48ADDF86.2040200@freescale.com>
References: <20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	<20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
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
Date: Thu, 21 Aug 2008 16:35:02 -0500

> David Miller wrote:
> > If you guys created this format in your compressed openfirmware
> > trees, is it possible for you to "fix" it to match what Sparc
> > systems following the proper bindings do?
> 
> Possibly, though it'll cause some pain when old trees are used with a 
> kernel that expects the new binding.
> 
> You mentioned having an actual binding document for I2C on Open 
> Firmware; is it available online anywhere?

It's a Sun internal document I got from a Sun employee, I'll ask
if there is a way I can at least share it with you privately so
you can use it as a reference.

> > Don't PowerMACs and such have I2C controllers and devices?
> > How do they encode these I2C client device reg properties?
> 
> As far as I can tell from poking around 
> http://penguinppc.org/historical/dev-trees-html/, they don't include reg 
> at all for i2c clients.

That actually simplifies things for us, thanks for checking.
