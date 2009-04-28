Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4B65DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 02:36:01 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3SGZeQB018514
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 09:35:51 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n3SGZeCQ029977
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 11:35:40 -0500 (CDT)
Date: Tue, 28 Apr 2009 11:35:40 -0500
From: Scott Wood <scottwood@freescale.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] 83xx: add support for the kmeter1 board.
Message-ID: <20090428163540.GA2193@ld0162-tx32.am.freescale.net>
References: <49F00605.1080605@denx.de>
	<6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
	<49F544DE.1010307@denx.de>
	<20090427180503.GB10292@ld0162-tx32.am.freescale.net>
	<49F68943.3090800@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49F68943.3090800@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 28, 2009 at 06:42:43AM +0200, Heiko Schocher wrote:
> Scott Wood wrote:
> > On Mon, Apr 27, 2009 at 07:38:38AM +0200, Heiko Schocher wrote:
> >> 1) add in the soc node an "errata" node and in this "errata" node
> >>    we can add all CPU specific errata as an example the qe_enet10
> >>    errata, which above code covers:
> > 
> > What about errata discovered after the device tree is deployed?
> 
> Didn;t know that there are such errata. Ok, this is a problem.

Bugs can be discovered at any point in time.

> > The presence of the erratum itself is indicated by the presence of the
> > buggy device, possibly in conjunction with SVR if the device tree is not
> > specific enough.
> 
> Ah, Ok, that was just an idea ... so, where and how to solve the qe_enet10
> errata without using get_immrbase()

Get the register block address from the par_io node.

-Scott
