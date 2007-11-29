Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id CC228DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 07:21:23 +1100 (EST)
Date: Thu, 29 Nov 2007 21:19:12 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: DS1337 RTC on I2C broken.
Message-ID: <20071129211912.46da8f5b@i1501.lan.towertech.it>
In-Reply-To: <474F1B25.8080508@anagramm.de>
References: <474DB27C.7020909@anagramm.de>
	<20071128194321.0804b3aa@i1501.lan.towertech.it>
	<474F1B25.8080508@anagramm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 29 Nov 2007 21:03:49 +0100
Clemens Koller <clemens.koller@anagramm.de> wrote:

> >> My guess is that the new rtc-lib's RTC_DRV_DS1307 support is still broken
> >> and it also breaks the deprecated SENSORS_DS1337. :-(
> 
> One more update:
> I am back to mainline (linus' .git) on 2.6.24-rc3-g09f345da to
> verify that the problem with the RTC still persists.
> 
> I startet to bisect, but ran quickly into other crashes.
> (no console on 2.6.23-rc2 and 2.6.23)
> So, I just can tell that it broke in between 2.6.22-rc6-gb75ae860 and
> and 2.6.24-rc2-ge6a5c27f.

 did you tried compiling it modular? you might even check with
 i2cdetect if the chip is there

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
