Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE451DE2CC
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 02:43:47 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n07FhiCf009914
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 08:43:44 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n07FhhKk022404
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 09:43:43 -0600 (CST)
Date: Wed, 7 Jan 2009 09:43:43 -0600
From: Scott Wood <scottwood@freescale.com>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Message-ID: <20090107154343.GC15585@ld0162-tx32.am.freescale.net>
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
	<C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<20081230201916.GA20059@oksana.dev.rtsoft.ru>
	<1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
	<20081231171017.6FCF585AD247@gemini.denx.de>
	<B64DF110-E26A-4229-8384-E7933732BC01@kernel.crashing.org>
	<20090105174645.GA23766@ld0162-tx32.am.freescale.net>
	<20090105180122.GA12237@oksana.dev.rtsoft.ru>
	<c384c5ea0901060418x48c507afq26bf6cec109ed9c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c384c5ea0901060418x48c507afq26bf6cec109ed9c4@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 06, 2009 at 01:18:56PM +0100, Leon Woestenberg wrote:
> Hello,
> 
> On Mon, Jan 5, 2009 at 7:01 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > On Mon, Jan 05, 2009 at 11:46:45AM -0600, Scott Wood wrote:
> > [...]
> >> > My statement was to convey that the kernel.org kernel should only
> >> > worry itself with the denx.de u-boot (w/regards to compatibility).
> >>
> >> Why?  Unless the BSP u-boots do something insane, I think we should try
> >> to have the upstream kernel boot on the u-boot that comes on the board
> >> (it's not nice to require users to reflash unnecessarily).
> >
> 
> The u-boot that came with the boards (at least MPC8315E-RDB) is too
> old for 2.6.25+ kernels:
> 
> I have run into this earlier:
> 
> http://www.mail-archive.com/u-boot-users@lists.sourceforge.net/msg06551.html

"It doesn't work" doesn't imply "It's worthless to try to make it work".

-Scott
