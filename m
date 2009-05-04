Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5CDE5DDE20
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 02:31:16 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n44GUuA1018041
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 09:31:07 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n44GUtIO024871
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 11:30:55 -0500 (CDT)
Date: Mon, 4 May 2009 11:30:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Landau, Bracha" <BLandau@nds.com>
Subject: Re: help with MPC8272ADS board
Message-ID: <20090504163055.GA16637@ld0162-tx32.am.freescale.net>
References: <065A7D06F7D4E546A18E80E08D066E1811892DD86B@ILMA1.IL.NDS.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E1811892DD86B@ILMA1.IL.NDS.COM>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 03, 2009 at 10:16:29AM +0300, Landau, Bracha wrote:
> I'm trying to get the MPC8272ADS evaluation board up and running with
> the latest versions of u-boot and Denx linux (2.6.24).

2.6.24 is nowhere near the latest version of Linux.  If you specifically
want to use a Denx kernel, you're better off at eldk@denx.de -- though
I'd be surprised if that's the latest they offer, either.

> I use the device tree file (mpc8272ads.dts) provided. Based on another
> post, I updated the MPC8260ADS.h file, changing OF_CPU from
> "cpu@0<mailto:cpu@0>" to "PowerPC,8272@0", because I was getting an
> error.

I'd rather change the device tree, instead.

> I tried booting both using a cuImage (cuImage.mpc8272ads) and a uImage
> with a device tree blob. Neither boot was successful, with no helpful
> information printed to the serial port.
> 
> Is there any change that has to be made in order to get the board to boot?

Upgrade to the latest kernel, and if it still doesn't work try enabling
the early debug console (note that the default address is currently for
cuImage).

-Scott
