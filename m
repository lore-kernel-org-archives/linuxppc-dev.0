Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5AD50DE040
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 05:15:28 +1000 (EST)
Message-ID: <47FD15E2.2050907@freescale.com>
Date: Wed, 09 Apr 2008 14:15:46 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: MPC8343 - "unable to handle paging request @ 0"
References: <47F73625.9040903@matrix-vision.de>
	<20080407161036.GA2688@loki.buserror.net>
	<47FB7822.6090401@matrix-vision.de>
	<20080408164853.GH2552@loki.buserror.net>
	<47FCBC73.40703@matrix-vision.de> <47FD118F.8050407@freescale.com>
	<47FD1485.6070209@matrix-vision.de>
In-Reply-To: <47FD1485.6070209@matrix-vision.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andre Schwarz wrote:
> Scott Wood schrieb:
>> Andre Schwarz wrote:
>>>  -> find_legacy_serial_port()
>>> stdout is /soc8343@e0000000/serial@4500
>>
>> It looks like you have some memory corruption between here...
>>
>>> clocksource: timebase mult[3c00001] shift[22] registered
>>>
>>> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
>>>  -> check_legacy_serial_console()
>>>  can't find stdout package /soc8343@e0000000/serial@4500 !
>>> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
>>
>> ...and here.
>>
>> -Scott
> 
> Scott,
> 
> are you talking about a possible hardware problem or misbehaving code ?

Either.  The same OF call is done in both places with the same argument, 
but is getting different results.

> Does it look like something gets overwritten during initrd 
> extraction/movement ?

Don't know.

> The system has 512MB RAM which means that we need 2 BAT regs to map the 
> memory. I've found comments in Freescale u-boot header files that 
> currently a max of 256MB is supported. I never understood why ? Could 
> this problem be related to this ?

Kim's probably be the best one to answer u-boot questions.

-Scott
