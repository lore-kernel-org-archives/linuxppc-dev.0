Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DC456DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Nov 2008 03:15:34 +1100 (EST)
Message-ID: <4911C695.4070401@freescale.com>
Date: Wed, 05 Nov 2008 10:15:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: Re: i2c driver's probe routine not getting called
References: <131123.51430.qm@web46312.mail.sp1.yahoo.com>
In-Reply-To: <131123.51430.qm@web46312.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Laxmikant Rashinkar wrote:
> I have linux-2.6.27.1 running on a MPC8347 based board.
> 
> When my freescale I2C driver is insmoded, it calls 
> platform_driver_register() successfully, but the probe routine doesn't 
> get called. 

Is "your" freescale I2C driver different from "the" freescale I2C driver 
in drivers/i2c/busses/i2c-mpc.c?  If so, you'll need to update it to be 
an of_platform driver like the in-tree driver is (or, just switch to the 
in-tree driver).

-Scott
