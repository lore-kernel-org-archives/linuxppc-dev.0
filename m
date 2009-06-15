Return-Path: <Kari.Davidsson@marel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3FAF7B70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 02:49:06 +1000 (EST)
Received: from mail.marel.is (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 79406DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 02:49:05 +1000 (EST)
Message-ID: <4A3678A3.1050802@marel.com>
Date: Mon, 15 Jun 2009 16:36:51 +0000
From: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>
MIME-Version: 1.0
Subject: Re: Chipselect in SPI binding with mpc5200-psc-spi
References: <fa686aa40902130719k1d16f936o4776cff371db16ae@mail.gmail.com>
In-Reply-To: <fa686aa40902130719k1d16f936o4776cff371db16ae@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Is this true?

Grant Likely wrote:
> 
> Yes, this is right.  The psc_spi driver automatically registers all
> spi children that it finds in the device tree onto the SPI bus.
> Therefore registering an spi_driver() is the right thing to do.

I am writing an SPI protocol driver and I find that my driver
is never probed.

I tried to add and call to of_register_spi_devices() in the
drivers/spi/mpc52xx_psc_spi.c::mpc52xx_psc_spi_of_probe() function,
without much effect besided that the DTS node is parsed but the driver probe
is not called, actually it complains about a modalias for my node is missing.

This is with kernel 2.6.29.3.

rg
kd
