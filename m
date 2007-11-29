Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 92888DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 07:03:45 +1100 (EST)
Message-ID: <474F1B25.8080508@anagramm.de>
Date: Thu, 29 Nov 2007 21:03:49 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: DS1337 RTC on I2C broken.
References: <474DB27C.7020909@anagramm.de>
	<20071128194321.0804b3aa@i1501.lan.towertech.it>
In-Reply-To: <20071128194321.0804b3aa@i1501.lan.towertech.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi There!

> Clemens Koller <clemens.koller@anagramm.de> wrote:
>> Well, as already mentioned, I have problems to get my DS1337 RTC on I2C
>> on my MPC8540(ads like) PowerPC working properly on
>> latest 2.6.24-rc2-ge6a5c27f kernels. A paulus.git 2.6.21-rc5-g9a5ee4cc
>> as well as a 2.6.22-rc6-gb75ae860 is working fine.
>> (mainstream's console is broken, so cannot test these, yet.)
>>
>>
>> My guess is that the new rtc-lib's RTC_DRV_DS1307 support is still broken
>> and it also breaks the deprecated SENSORS_DS1337. :-(

One more update:
I am back to mainline (linus' .git) on 2.6.24-rc3-g09f345da to
verify that the problem with the RTC still persists.

I startet to bisect, but ran quickly into other crashes.
(no console on 2.6.23-rc2 and 2.6.23)
So, I just can tell that it broke in between 2.6.22-rc6-gb75ae860 and
and 2.6.24-rc2-ge6a5c27f.

Regards,

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
