Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96E78DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 01:59:38 +1100 (EST)
Message-ID: <4933FBC6.50100@freescale.com>
Date: Mon, 01 Dec 2008 08:59:18 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: i2c-mpc clocking scheme
References: <492EB606.9020703@matrix-vision.de>
	<ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
	<492EC031.9000802@matrix-vision.de>
	<Pine.LNX.4.64.0811281255001.12483@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0811281255001.12483@t2.domain.actdsltmp>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trent Piepho wrote:

> Seems like it should keep the clock registers at what u-boot set them too.

Or we could have U-Boot put the i2c clock frequency into the I2C node, and let
the driver program the hardware again.  That would keep the ugliness in U-Boot.

-- 
Timur Tabi
Linux kernel developer at Freescale
