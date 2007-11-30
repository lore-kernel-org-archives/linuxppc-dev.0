Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 3F786DDEB9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 22:23:16 +1100 (EST)
Date: Fri, 30 Nov 2007 12:20:55 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
Message-ID: <20071130122055.729dd3f8@i1501.lan.towertech.it>
In-Reply-To: <474FEE20.6070606@anagramm.de>
References: <474DB27C.7020909@anagramm.de>
	<20071128194321.0804b3aa@i1501.lan.towertech.it>
	<474F1B25.8080508@anagramm.de>
	<20071129211912.46da8f5b@i1501.lan.towertech.it>
	<474FEE20.6070606@anagramm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 30 Nov 2007 12:04:00 +0100
Clemens Koller <clemens.koller@anagramm.de> wrote:

> A kernel upgrade doesn't make the chip to disappear ;-)
> The I2C bus is/was basically working fine all the time... see below.

 you never know those pesky chips ;)
 
> Modular doesn't make sense to me, because the filesystem check starts
> to complain when last mount time was way to far in the past or in
> the future. But I will try...

 It's just to see if there's any timing issue like module-coming-up-before-bus-and/or-rtc.
 it should work anyway, but who knows...
 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
