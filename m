Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id BF901DDE47
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 07:36:34 +1100 (EST)
Date: Wed, 28 Nov 2007 21:34:37 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
Message-ID: <20071128213437.0d577bff@i1501.lan.towertech.it>
In-Reply-To: <474DC326.6070209@anagramm.de>
References: <474DB27C.7020909@anagramm.de>
	<20071128194321.0804b3aa@i1501.lan.towertech.it>
	<474DC326.6070209@anagramm.de>
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

On Wed, 28 Nov 2007 20:36:06 +0100
Clemens Koller <clemens.koller@anagramm.de> wrote:

> My current
> .config as well as the dmesg is attached with your
> suggested changes.

 one more test, please. can you try compiling rtc-ds1307 as 
 a module and then kick it in via modprobe?


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
