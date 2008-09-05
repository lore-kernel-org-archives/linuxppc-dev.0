Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 77646DE12C
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 02:00:25 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m85G0JWr026844
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 09:00:19 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m85G0Ib8027368
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 11:00:18 -0500 (CDT)
Date: Fri, 5 Sep 2008 11:00:18 -0500
From: Scott Wood <scottwood@freescale.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] powerpc/44x: Add hwmon support to Sequoia device tree
Message-ID: <20080905160017.GA22310@ld0162-tx32.am.freescale.net>
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>
	<200809041628.29460.matthias.fuchs@esd-electronics.com>
	<200809041641.57614.matthias.fuchs@esd-electronics.com>
	<200809051219.43906.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200809051219.43906.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 05, 2008 at 12:19:43PM +0200, Stefan Roese wrote:
> > +
> > +				hwmon@48 {
> 
> Not sure if we shouldn't use
> 
>                                 ad7414@48 {
> 
> here. This is the way it is already done in warp.dts.

We shouldn't.  Node names are supposed to be generic:
http://playground.sun.com/1275/practice/gnames/gnamv14a.html

-Scott
