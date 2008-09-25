Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A94E0DE289
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 03:59:14 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m8PHx8bU013261
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 10:59:09 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m8PHx83U027661
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 12:59:08 -0500 (CDT)
Date: Thu, 25 Sep 2008 12:59:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] GPIO-Watchdog in devicetree
Message-ID: <20080925175907.GA4747@ld0162-tx32.am.freescale.net>
References: <20080922194357.GA32041@pengutronix.de>
	<20080923150256.GC13593@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080923150256.GC13593@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 23, 2008 at 09:02:56AM -0600, Grant Likely wrote:
> For example:
> / {
> 	model = "pengutronix,super-sexy-board";
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	super-sexy-board,watchdog-gpio = <&gpio_simple 19 0>;
> 	...
> }

Why as a property of the root node, and not as a node with a very
specific compatible property?

-Scott
