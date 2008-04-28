Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 59029DDF37
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 06:24:50 +1000 (EST)
Message-ID: <4816327C.3080207@scram.de>
Date: Mon, 28 Apr 2008 22:24:28 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [i2c] [PATCH 0/2] i2c: Add support for device alias names
References: <20080428113052.6d024bda@hyperion.delvare>
	<20080428153543.GB4353@pengutronix.de>
In-Reply-To: <20080428153543.GB4353@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-15
Cc: Sievers <kay.sievers@vrfy.org>, Laurent@ATrpms.net,
	Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>, Linux I2C <i2c@lm-sensors.org>,
	Kay@ATrpms.net, Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Wolfram,

> I tested on this hardware
> 
>  MPC8260 (powerpc) + PCF8575 (io expander) + LM84 (sensor)
>  + RS5C372 (rtc) + X24645 (eeprom)

It's also OK on dbox2 hardware: MPC823 (powerpc)
+ saa7127 (patch needed to add id_table) + dbox frontprocessor
(8051 controller with i2c interface).

Thanks,
Jochen
