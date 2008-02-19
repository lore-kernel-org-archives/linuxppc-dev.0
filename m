Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 9D54CDDE02
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 09:36:54 +1100 (EST)
Message-ID: <47BB589E.4040201@anagramm.de>
Date: Tue, 19 Feb 2008 23:30:54 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Marc LeFevre <lfx@cypress.com>
Subject: Re: RTC woes
References: <06cb01c87315$5dad6010$f30213ac@isd.cypress.com>
In-Reply-To: <06cb01c87315$5dad6010$f30213ac@isd.cypress.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marc LeFevre schrieb:
> I’m new to the list.

Welcome! :-)

 > I have an e500-based embedded Linux system running
> a 2.6.22 kernel.  I have a PCF8563T i2c based RTC chip attached to the 
> PPC i2c bus.  In my kernel config file I have selected 
> CONFIG_RTC_INTF_DEV=y and CONFIG_RTC_DRV_PCF8563=y.  I do a mknod  for 
> /dev/rtc as c 10 135 (standard Linux) and link /dev/rtc0 to it.
> 
  > When I boot, get the following message:
> 
> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)

2.6.22.x and 2.6.23.x i2c rtc code was quite messy around PCF8563.

> 3)       Does the PPC have some quirks regarding i2c operation that are 
> at the root of this problem?

The RTC subsystem was improved quite a bit lately. Try 2.6.24' powerpc
architecture with a proper device tree instead. It works over here on
mpc8540 / mpc8548 whereas the older ones were just a waste of time.

Regards,

Clemens
