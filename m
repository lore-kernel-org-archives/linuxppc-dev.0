Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 23AF8DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 22:19:27 +1000 (EST)
Message-ID: <49FEDD42.4030806@mlbassoc.com>
Date: Mon, 04 May 2009 06:19:14 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Using archaic I2C with OF
References: <49FAF351.4010409@mlbassoc.com>	<9e4733910905010739q4038555ck211ee61b9b443f01@mail.gmail.com>	<9e4733910905010739p6c4fddf3oab1b583b72df4eeb@mail.gmail.com>	<49FB0C3B.3000209@mlbassoc.com>	<9e4733910905010755g595d686fmf075a40d6012e3fc@mail.gmail.com>
	<20090501160403.GA7943@pengutronix.de>
In-Reply-To: <20090501160403.GA7943@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfram Sang wrote:
>> Post this on the i2c list. Jean has made an effort to convert all
>> drivers. He must have missed that one.
>>     
>
> What Jean did was converting all drivers who used the legacy i2c-binding to use
> the new binding which is a lot better suited to the driver model. The above
> mentioned driver already uses the new binding.
>
> The problem coming up here is another issue and also long standing and not yet
> solved. There are drivers which require platform_data with function pointers.
> You cannot encode function pointers to the device tree.
>
> One solution is to create a custom driver for your board with the needed
> specific function and create a platform device from there. Sometimes it
> works to add a bit more info to the device tree (e.g. some gpios) and
> parse it via an of_wrapper around the platform driver.
>   
So somehow, I need to create a platform driver, possibly inside an
of_wrapper, which
eventually instantiates an I2C device on a particular bus, with my
specific platform
data. 

Sorry, but I'm lost here.  How do I untangle this maze of twisty little
passages?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
