Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 6C1B9DDEBD
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:47:27 +1000 (EST)
Date: Tue, 03 Apr 2007 18:47:27 -0700 (PDT)
Message-Id: <20070403.184727.26533881.davem@davemloft.net>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070404023637.65c56227@the-village.bc.nu>
References: <20070404021924.71e87580@the-village.bc.nu>
	<20070403.182125.77058566.davem@davemloft.net>
	<20070404023637.65c56227@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: dwmw2@infradead.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 4 Apr 2007 02:36:37 +0100

> I've no fundamental problem with S0->console port 1, S1 -> console port 2
> etc, but the general notion that type and positional information doesn't
> matter is complete and utter bollocks when you try and apply it to any
> serious serial setup.

If you want geographical type device specification hierarchies, to
sanely manage that kind of stuff, they belong via sysfs or something
userside like that.

Using a bunch of different majors does not help the situation you
speak of.

What if I have 1,000 cyclades cards in my system?  The cyclades
serial major number helps me diddly in that case.  What about
having 82 8250's?
