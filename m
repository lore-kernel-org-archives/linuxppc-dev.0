Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12550DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 02:17:07 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m9LFGnL1028264
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 08:17:00 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m9LFGneY019141
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 10:16:49 -0500 (CDT)
Date: Tue, 21 Oct 2008 10:16:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
Message-ID: <20081021151648.GA20757@ld0162-tx32.am.freescale.net>
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
	<Pine.LNX.4.64.0810132003350.9041@axis700.grange>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
	<20081019025323.GA7887@ime.usp.br>
	<Pine.LNX.4.64.0810192147030.21665@axis700.grange>
	<9e4733910810191432o58d204adw490cb8e4fcc390ac@mail.gmail.com>
	<Pine.LNX.4.64.0810192347250.21665@axis700.grange>
	<9e4733910810191505u3ec1db0dl25e87bf3b78c740d@mail.gmail.com>
	<Pine.LNX.4.64.0810200022040.21665@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0810200022040.21665@axis700.grange>
Cc: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 20, 2008 at 12:28:09AM +0200, Guennadi Liakhovetski wrote:
> On Sun, 19 Oct 2008, Jon Smirl wrote:
> > That should match:
> > 
> > 		i2c@80003000 {
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 			cell-index = <0>;
> > 			compatible = "fsl-i2c";
> > 			reg = <0x80003000 0x1000>;
> > 			interrupts = <5 2>;
> > 			interrupt-parent = <&mpic>;
> > 
> > 			rtc@32 {
> > 				device_type = "rtc";
> > 				compatible = "ricoh,rs5c372a";
> > 				reg = <0x32>;
> > 			};
> > 		};
> 
> It should, but it doesn't.

Is the parent of the i2c node covered by the list passed to
of_platform_bus_probe() on this board?

-Scott
