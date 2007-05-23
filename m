Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8E70DDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 01:56:02 +1000 (EST)
In-Reply-To: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <30282286f39c1489db7ad5b05acbc1bd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: TSI ethernet PHY question
Date: Wed, 23 May 2007 17:55:45 +0200
To: "Alexandre Bounine" <Alexandre.Bounine@tundra.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On power up, because this pin is pulled high by the LED, the
> TXC_RXC_DELAY mode is enabled, causing a 1.9ns delay between the clock
> and data on the GMII interface. Tsi109 could not operate properly with
> this delay. The TXC_RXC_DELAY mode has to be disabled by software.
>
> If the Quality/TXC_RXC_DELAY pin is left not connected PHY will work in
> normal mode without delay and therefore the workaround is not required.

So it is a board-specific workaround.

> I think that for situations like one on the Holly board we may need
> board-specific hooks which modify normal initialization. As in our 
> case:
> no LED - no trouble.

Should be initiated from the platform code yes; it could
be as simple as passing a flag to the init function.

> -----Original Message-----

Don't top-post :-)


Segher
