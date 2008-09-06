Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E49DADDE26
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Sep 2008 01:03:20 +1000 (EST)
Message-ID: <48C29CA3.80806@grandegger.com>
Date: Sat, 06 Sep 2008 17:07:15 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: [PATCH] powerpc/44x: Add hwmon support to Sequoia device tree
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>	<20080905160017.GA22310@ld0162-tx32.am.freescale.net>	<20080905201703.0586e131@lappy.seanm.ca>
	<200809061440.41629.matthias.fuchs@esd-electronics.com>
In-Reply-To: <200809061440.41629.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matthias Fuchs wrote:
> Hi,
> 
> I have chosen "hwmon" because those drivers are placed in the kernel's
> drivers/hwmon subdirectory. "temp" sounds to much like "temporary" for
> me :-)

How about "dtt"? That's what we use in U-Boot for digital temperature
sensors as well.

> We can name it "sensor" - inspired by the lm-sensors projects that 
> takes care of such sensors. Because these type of devices are not always
> used to monitor the whatever hardware  ... sensor could even be better.
> 
> So my favorites are sensor@ or hwmon@.
> 
> Sean, I can take your "adi" instead of "analog" for this special sensor.

"adi" sounds more reasonable, indeed and as the OF software ignores the
vendor field, changing the name should not harm.

Wolfgang.
