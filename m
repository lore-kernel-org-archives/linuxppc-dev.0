Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 758D5DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 06:25:47 +1100 (EST)
Date: Mon, 27 Oct 2008 12:25:24 -0700 (PDT)
Message-Id: <20081027.122524.147654861.davem@davemloft.net>
To: cfriesen@nortel.com
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
From: David Miller <davem@davemloft.net>
In-Reply-To: <4906123F.7020802@nortel.com>
References: <4905FC15.3020702@nortel.com>
	<20081027.112823.178324048.davem@davemloft.net>
	<4906123F.7020802@nortel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kevdig@hypersurf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Chris Friesen" <cfriesen@nortel.com>
Date: Mon, 27 Oct 2008 13:10:55 -0600

> David Miller wrote:
> > From: "Chris Friesen" <cfriesen@nortel.com>
> 
> > Hello, we either have hardware that does flow seperation and has multiple
> > RX queues going to multiple MSI-X interrupts or we do flow seperation in
> > software (work in progress patches were posted for that about a month ago,
> > maybe something final will land in 2.6.29)
>
> Are there any plans for a mechanism to allow the kernel to figure
> out (or be told) what packets cpu-affined tasks are interested in
> and route the interrupts appropriately?

No, not at all.

Now there are plans to allow the user to add classification rules into
the chip for specific flows, on hardware that supports this, via ethtool.

> Ideally I agree with you.  In this particular case however the
> hardware is capable of doing flow separation, but the vendor driver
> doesn't support it (and isn't in mainline).  Packet rates are high
> enough that a single core cannot keep up, but are low enough that
> they can be handled by multiple cores without reordering if
> interrupt mitigation is not used.

Your driver is weak and doesn't support the hardware correctly, and you
want to put the onus on everyone else with sane hardware and drivers?

> It's not an ideal situation, but we're sort of stuck unless we do
> custom driver work.

Wouldn't want you to get your hands dirty or anything like that now,
would we?  :-)))
