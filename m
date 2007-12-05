Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id D9C88DDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Dec 2007 21:27:35 +1100 (EST)
Message-ID: <47567D1C.5020908@anagramm.de>
Date: Wed, 05 Dec 2007 11:27:40 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: OT: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474FEE20.6070606@anagramm.de>
	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47541D70.2040805@anagramm.de> <47542A50.1030208@anagramm.de>
	<47543351.2080904@freescale.com> <47543FAD.7040504@anagramm.de>
	<475445DF.6080202@freescale.com> <47545A81.90804@anagramm.de>
	<20071203204652.GB4850@loki.buserror.net>
	<47553D31.4080306@anagramm.de>
	<20071204130841.GA5765@loki.buserror.net>
	<4755731D.4050106@anagramm.de> <47557B6B.9020105@freescale.com>
In-Reply-To: <47557B6B.9020105@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Scott!

 >> Well, the subject is about RTCs.
 >
 > Not really, it's about a change in the i2c subsystem (I noticed you
 > didn't include the i2c list or linuxppc-dev... you'd get a larger
 > audience of the people that actually made the change that way).  That it
 > happens to be an RTC chip you're using on the i2c bus is an
 > inconsequential detail.

Looks like I wasn't subscribed to the list anymore, so I
missed lots of DT related discussions - my bad. :-(

 >> Well... let's take it easy. I'll dig into the pcf8563 code now.
 >
 > BTW, there were patches posted recently by Jon Smirl to convert that
 > driver to new-style, and to change the i2c subsystem to have the OF
 > matches in the driver itself.

That looks promising. I really didn't expect to find rtc driver names
in fsl_soc.c...

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
