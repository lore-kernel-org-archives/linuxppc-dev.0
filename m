Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F8BBDE072
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 04:46:54 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n05Hkkx8006672
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 10:46:51 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n05HkjYp018765
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 11:46:45 -0600 (CST)
Date: Mon, 5 Jan 2009 11:46:45 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Message-ID: <20090105174645.GA23766@ld0162-tx32.am.freescale.net>
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
	<C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
	<20081230201916.GA20059@oksana.dev.rtsoft.ru>
	<1F7739C2-930B-49C1-B8FF-679AF1BBAEAE@kernel.crashing.org>
	<20081231171017.6FCF585AD247@gemini.denx.de>
	<B64DF110-E26A-4229-8384-E7933732BC01@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B64DF110-E26A-4229-8384-E7933732BC01@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 01, 2009 at 08:26:14AM -0600, Kumar Gala wrote:
> I meant the official u-boot from denx.de vs the one FSL ships w/its  
> boards & BSPs.  The BSP u-boot has modifications that don't exist in  
> the denx.de u-boot (as the quality of the code is not up to open  
> source standards).

I believe "upstream" is the word you're looking for.

> My statement was to convey that the kernel.org kernel should only  
> worry itself with the denx.de u-boot (w/regards to compatibility).

Why?  Unless the BSP u-boots do something insane, I think we should try
to have the upstream kernel boot on the u-boot that comes on the board
(it's not nice to require users to reflash unnecessarily).

That said, the device tree should come from u-boot, not from the kernel.

-Scott
