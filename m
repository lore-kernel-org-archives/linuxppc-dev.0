Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24803DE14B
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 02:00:53 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3NG0nPG026992
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 09:00:49 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n3NG0mar004338
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 11:00:48 -0500 (CDT)
Date: Thu, 23 Apr 2009 11:00:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: removing get_immrbase()??
Message-ID: <20090423160048.GC19717@ld0162-tx32.am.freescale.net>
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8E3A.4060304@freescale.com>
	<5D0145E3-0A98-429E-8D53-1A8DF4216462@kernel.crashing.org>
	<20090423022610.GA19376@yookeroo.seuss>
	<49F066DC.402@freescale.com>
	<20090423135005.GA18462@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090423135005.GA18462@oksana.dev.rtsoft.ru>
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

On Thu, Apr 23, 2009 at 05:50:05PM +0400, Anton Vorontsov wrote:
> As for Freescale parts, all the reference board I've seen were
> very friendly wrt upgrading their device-trees, i.e. none of
> the boards were shipping with device-tree soldered into the
> firmware.

But many of them have broken when a dtb that u-boot didn't like was
inserted.

> And note that most developers are using up-to-date firmwares
> (U-Boots), device trees, and kernels. 

So then why did we have to make cuImage?

> And that means that old device-tree + new kernel combination is left
> untested for years. And untested stuff is broken stuff, by definition.

There's a difference between risking that something may be broken, and
gratuitously making it broken.

> Sure, there is a completely different story wrt device-tree
> changes that might break firmwares. And that I believe we'd
> better avoid. For example device_type = "soc", if removed,
> most firmwares would not fix-up {clock,bus}-frequency properties.

Even if the given change may not break the firmware, it could force an
update in which a prior change breaks the firmware.

-Scott
