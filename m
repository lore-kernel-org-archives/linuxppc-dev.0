Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 91F8BDDF18
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 00:17:43 +1000 (EST)
In-Reply-To: <20070525020059.GA13575@localhost.localdomain>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
	<1179960728.32247.953.camel@localhost.localdomain>
	<396FEEDC-99AB-4E25-9C80-A901923429B0@freescale.com>
	<1180047084.32247.1070.camel@localhost.localdomain>
	<2994f78d2591e45517247003d613bb98@kernel.crashing.org>
	<20070525020059.GA13575@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e97f5fb5861fe4177dc6b37bdc0e0244@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: TSI ethernet PHY question
Date: Fri, 25 May 2007 16:17:32 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Since the specific bug we're talking about here is not a
>> problem with the PHY, but a miswiring on the board, I wouldn't
>> put a flag for the workaround in the phy node in the device
>> tree.  It certainly is an option though.
>
> Uh.. something to bear in mind is that although it is a board
> miswiring, it's of a type that it will plausibly occur in other
> boards.

It is possible yes.

> IIRC, if a LED is attached to this PHY the workaround is
> necessary, or something similar.

Only if it is attached the wrong way, so it acts as a
pull-up (or was it pull-down) during chip reset.

>   So there is value in having a
> particular flag for this rather than just looking at the board model.

A bit, maybe.


Segher
