Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 0ED1BDDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 03:38:09 +1100 (EST)
Message-ID: <475430ED.1080204@anagramm.de>
Date: Mon, 03 Dec 2007 17:38:05 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Bartlomiej Sieka <tur@semihalf.com>
Subject: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474DB27C.7020909@anagramm.de>	<20071128194321.0804b3aa@i1501.lan.towertech.it>	<474F1B25.8080508@anagramm.de>	<20071129211912.46da8f5b@i1501.lan.towertech.it>	<474FEE20.6070606@anagramm.de>	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47541D70.2040805@anagramm.de> <475429DA.9060100@semihalf.com>
In-Reply-To: <475429DA.9060100@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi, Bartlomiej!

Bartlomiej Sieka schrieb:
 > Do you have rtc node in your dts file (I'm assuming arch/powerpc
 > situation)? If not, you'll have to add it - for example similarly to
 > what's being done in the attached patch (68 is the I2C address of the
 > RTC chip - a DS1339 in my case).

Thank you also for your hint... that was indeed the problem here.
Simple but not really obvious.

Is it possible to have a maximum generic .dts configuration where the
kernel is told to include any device it propably finds?

I guess the failing reset since 2.6.22 is also just an entry in
my .dts... ?

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
