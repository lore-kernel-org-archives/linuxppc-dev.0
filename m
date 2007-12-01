Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id D1F25DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 23:19:20 +1100 (EST)
Date: Sat, 1 Dec 2007 13:16:44 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
Message-ID: <20071201131644.1c6dd6bb@i1501.lan.towertech.it>
In-Reply-To: <47505271.8030102@anagramm.de>
References: <474DB27C.7020909@anagramm.de>
	<20071128194321.0804b3aa@i1501.lan.towertech.it>
	<474F1B25.8080508@anagramm.de>
	<20071129211912.46da8f5b@i1501.lan.towertech.it>
	<474FEE20.6070606@anagramm.de>
	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47505271.8030102@anagramm.de>
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

On Fri, 30 Nov 2007 19:12:01 +0100
Clemens Koller <clemens.koller@anagramm.de> wrote:

> root@fox_1:/lib/modules/2.6.24-rc3-ge1cca7e8/kernel/drivers/rtc$ modprobe rtc-ds1307

 what is dmesg saying at this time?

 you might want to add some debug statements in the driver
 to see where it halts.. i guess the driver is not bound
 to the chip for some reason.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
