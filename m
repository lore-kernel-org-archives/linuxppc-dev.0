Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8766EDDDCA
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 18:43:07 +1100 (EST)
Date: Tue, 2 Dec 2008 23:40:57 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [U-Boot] NAND only (no NOR)
In-Reply-To: <20081203013818.016619b6@lappy.seanm.ca>
Message-ID: <Pine.LNX.4.64.0812022339030.10176@t2.domain.actdsltmp>
References: <4934F7FC.2030105@aimvalley.nl>
	<20081202215033.501f3403@lappy.seanm.ca>
	<200812030648.57618.sr@denx.de>
	<20081203013818.016619b6@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
	Norbert van Bolhuis <nvbolhuis@aimvalley.nl>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 3 Dec 2008, Sean MacLennan wrote:
>> Yes, I would recommend to do it this way if possible. A small NOR for
>> U-Boot and environment and everything else in NAND. This makes things
>> much easier. But I understand that this is sometimes a problem with
>> space (2 FLASH chips) and costs.
>
> Mainly cost. We didn't want to pay for a second chip.

I think for NAND the latches necessary to de-multiplex the localbus aren't
necessary like they are for NOR?  On our board the latches might even take
more space than the flash chip.
