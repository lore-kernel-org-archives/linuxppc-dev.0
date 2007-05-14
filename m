Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2DDC4DDE09
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 00:47:03 +1000 (EST)
In-Reply-To: <4647B95D.1040404@genesi-usa.com>
References: <20070423144052.261f68ad.kim.phillips@freescale.com>	<5c96dd623e3a6737db48ab17c3550610@kernel.crashing.org>
	<20070423160621.329d1a08.kim.phillips@freescale.com>
	<4647B95D.1040404@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <476ad1acff453df4cd02d7e1f8db7b03@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v4] powerpc: document phy-connection-type property
Date: Mon, 14 May 2007 14:44:17 +0200
To: Matt Sealey <matt@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Since I'm poking around on 52xx I had a query - firstly it doesn't
> look like the 52xx fec driver uses phylib at all since it also tries
> to support the 7-wire ethernet interface, which isn't ?? supported
> by phylib.
>
> Stumbling across this property I wondered, if the driver can check
> the device tree for the phy type to set it up properly in this
> manner, would it also be relevant to list the 7-wire style of
> connection, so that drivers can provide the alternative code?

Is that 7-wire thing just another kind of connection
to a PHY?  If so, treat it as such (add phylib support
perhaps); if not, have an empty property in your 5200
ethernet node that says the 7-wire thing is in use.


Segher
