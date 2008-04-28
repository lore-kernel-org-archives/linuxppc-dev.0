Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1C43DE4C2
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 06:31:17 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3SKU5wF002198
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 13:30:05 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3SKU47R013254
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 15:30:05 -0500 (CDT)
Date: Mon, 28 Apr 2008 15:30:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: [PATCH 1/2] [MTD] Add support for RAM & ROMmappings in the
	physmap_of MTD driver.
Message-ID: <20080428203004.GC15223@ld0162-tx32.am.freescale.net>
References: <200804251353.13698.laurentp@cse-semaphore.com>
	<DCEAAC0833DD314AB0B58112AD99B93B04512785@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04512785@ismail.innsys.innovsys.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 11:26:15AM -0500, Rune Torgersen wrote:
> Examples would be the FCC's on a Freescale PQ2 chip, where they are
> encoded as ethernet controllers. (Thsy could be used as high-speed HDLC
> controllers, ATM controllers and other usages), the SCC ports (as
> serial, they can be used for syncronous serial and HDLC)

But that choice is made by board-level hardware, not purely by software.

-Scott
