Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 05DD3DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Dec 2007 07:21:37 +1100 (EST)
Date: Sun, 2 Dec 2007 14:25:21 -0600
From: Olof Johansson <olof@lixom.net>
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
Message-ID: <20071202202521.GA15665@lixom.net>
References: <474DB27C.7020909@anagramm.de>
	<20071128194321.0804b3aa@i1501.lan.towertech.it>
	<474F1B25.8080508@anagramm.de>
	<20071129211912.46da8f5b@i1501.lan.towertech.it>
	<474FEE20.6070606@anagramm.de>
	<20071130122055.729dd3f8@i1501.lan.towertech.it>
	<47501A4F.8050400@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47501A4F.8050400@anagramm.de>
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

On Fri, Nov 30, 2007 at 03:12:31PM +0100, Clemens Koller wrote:
> Hello, Alessandro!
>
> Alessandro Zummo schrieb:
> >  It's just to see if there's any timing issue like 
> module-coming-up-before-bus-and/or-rtc.
> >  it should work anyway, but who knows...
>
> Here comes more debugging output:
>
> Please note that I have now _two_ almost identical systems up and running 
> with the
> latest kernel. One machine (ecam) with an pcf8563 RTC on I2C and another 
> one (fox_1)
> with an DS1337. Both RTCs work, but the kernel doesn't get the time right.

ds1307 requires you to register i2c_board_info for it to probe properly.
Does your platform do so?



-Olof
