Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 41723DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 23:26:58 +1100 (EST)
Date: Sat, 1 Dec 2007 13:24:23 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
Message-ID: <20071201132423.50fbedc0@i1501.lan.towertech.it>
In-Reply-To: <47501A4F.8050400@anagramm.de>
References: <474DB27C.7020909@anagramm.de>
	<20071128194321.0804b3aa@i1501.lan.towertech.it>
	<474F1B25.8080508@anagramm.de>
	<20071129211912.46da8f5b@i1501.lan.towertech.it>
	<474FEE20.6070606@anagramm.de>
	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47501A4F.8050400@anagramm.de>
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

On Fri, 30 Nov 2007 15:12:31 +0100
Clemens Koller <clemens.koller@anagramm.de> wrote:

> Hello, Alessandro!
> 
> Alessandro Zummo schrieb:
>  >  It's just to see if there's any timing issue like module-coming-up-before-bus-and/or-rtc.
>  >  it should work anyway, but who knows...  
> 
> Here comes more debugging output:


 [..]

 your .config is right, the drivers are loaded
 but they are not bound to the chips as they are supposed to do.

 can you check that i2c_board_info structures / i2c_register_board_info
 are used by your platform?

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
