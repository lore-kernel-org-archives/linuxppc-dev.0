Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 33CFADDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 06:20:41 +1100 (EST)
Message-ID: <474DBF7A.7030507@anagramm.de>
Date: Wed, 28 Nov 2007 20:20:26 +0100
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

Hi, Alessandro!

Thank you for your quick response... I'll just follow your
ideas and provide you with the dmesg output ASAP.

If you are online for some more time, I will accelerate
this debugging session... Just let me know.

Alessandro Zummo schrieb:
> On Wed, 28 Nov 2007 19:25:00 +0100
> Clemens Koller <clemens.koller@anagramm.de> wrote:
> 
>> Well, as already mentioned, I have problems to get my DS1337 RTC on I2C
>> on my MPC8540(ads like) PowerPC working properly on
>> latest 2.6.24-rc2-ge6a5c27f kernels. A paulus.git 2.6.21-rc5-g9a5ee4cc
>> as well as a 2.6.22-rc6-gb75ae860 is working fine.
>> (mainstream's console is broken, so cannot test these, yet.)
>>
>>
>> My guess is that the new rtc-lib's RTC_DRV_DS1307 support is still broken
>> and it also breaks the deprecated SENSORS_DS1337. :-(
> 
>  mmm. I've been told it should work ;)

> 
>> Here is a snippet from my .config which is similar among my kernels.
>> CONFIG_GEN_RTC=y
> 
>  this one must be deselected.
> 
>> CONFIG_SENSORS_DS1337=y
>> CONFIG_SENSORS_DS1374=y
> 
>  ditto.

Will do.

> 
>> DEV: registering device: ID = '0-0068'
>> bus i2c: add device 0-0068
>> bound device '0-0068' to driver 'ds1337'
> 
>  maybe the wrong driver is kicking in here.
>  the fact that there is no rtc class
>  related output in dmesg should and that
>  there is no /dev/rtc0 could be a sign that the whole class
>  is not going in.
> 
>  do you have full dmesg? 

Not a full one from the 2.6.24 right now...
But I'll disable above stuff and get you a full one.
(in 5..10 minutes).

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
