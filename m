Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5733FDE335
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 08:48:36 +1100 (EST)
Message-ID: <47E2DBB5.9050604@freescale.com>
Date: Thu, 20 Mar 2008 16:48:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: DTS question
References: <20080320173302.7075a1d9@lappy.seanm.ca>
In-Reply-To: <20080320173302.7075a1d9@lappy.seanm.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sean MacLennan wrote:
> The warp has an AD7414 chip hanging off the I2C bus. This chip can
> raise an interrupt when it crosses a critical threshold.
> 
> This interrupt is tied to IRQ2 from the processor. What is the best
> way to describe this interrupt in the DTS?
> 
> The warp.dts is available on request, but the one in the for-2.6.25
> tree is relatively up to date.

Add a node for the ad7414 under the i2c bus, and put the interrupt 
specifier there.  For best results, convert the ad7414 driver into a 
new-style i2c driver.

-Scott
