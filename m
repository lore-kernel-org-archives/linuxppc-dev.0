Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 109A0DE0D2
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 04:00:17 +1000 (EST)
Message-ID: <49F0AC9C.7060905@freescale.com>
Date: Thu, 23 Apr 2009 12:59:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: removing get_immrbase()??
References: <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
	<49F066DC.402@freescale.com>
	<20090423135005.GA18462@oksana.dev.rtsoft.ru>
	<20090423160048.GC19717@ld0162-tx32.am.freescale.net>
	<20090423165430.GA8355@oksana.dev.rtsoft.ru>
	<49F09F4A.8090506@freescale.com>
	<20090423172633.GA16375@oksana.dev.rtsoft.ru>
In-Reply-To: <20090423172633.GA16375@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> This is exactly what we should try to avoid. We should not accept
> any changes that might break older firmwares. That is, keep the
> device tree workable with X1 and X2, by any means.

I think that's a much bigger restriction than trying to keep the kernel 
compatible with older device trees.  Consider changes in the physical 
memory map, etc.

> If X1 looks for "/soc8323@..."  and X2 looks for "/soc@...", so that
> Z1 and Z2 aren't compatible at all, then we're in trouble. But we're
> in trouble regardless of what Linux is doing, no?

Not if Linux can continue to deal with X1 and Z1.

-Scott
