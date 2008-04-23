Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 77A10DDF43
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 04:19:23 +1000 (EST)
Message-ID: <480F7E02.4020400@scram.de>
Date: Wed, 23 Apr 2008 20:20:50 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [i2c] platform_data when using of?
References: <20080423164523.GA4190@pengutronix.de>
In-Reply-To: <20080423164523.GA4190@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Wolfram,

> Hello,
> 
> I finally could get the work started with I2C on a MPC8260-based
> platform. I applied Jochen's series on top of 2.6.25 and it seems I
> could get the i2c-cpm and the rtc-rs5c372 driver working (except that it
> doesn't autoload as a module, but I think this is my fault somewhere).
> I have not checked all yet, but at least some reasonable things do happen.
> 
> I now wanted to test the latest at24-driver on top of that and stumbled
> over the fact, that I can't directly add platform_data to the dts-file.
> (As at24 shall be a generic driver, data about the eeprom type needs to
> be provided.) If I understood of correctly, I need to create another
> child node and put all necessary data in there (what also means one
> cannot use the predefined macros for known chips in at24.h). After that
> I use of_get_property and collect the data.
> 
> So, at the end, every driver using platform_data has to cope with two
> mechanisms to get the desired data? This sounds questionable to me, but
> maybe I just got something wrong as this is my first contact with of.
> 
> Kind regards,
> 
>    Wolfram

You should probably send this question to the Powerpc list (added to cc)

Thanks,
Jochen
