Return-Path: <tnt@246tNt.com>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.4.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E3B967C1A
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 18:18:25 +1100 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBI7IH3e014010
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 08:18:17 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45864068.1060606@246tNt.com>
Date: Mon, 18 Dec 2006 08:16:56 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] uevents handler for macio & of_platform
References: <11663742771972-git-send-email-tnt@246tNt.com>
	<200612180004.44933.arnd@arndb.de>
In-Reply-To: <200612180004.44933.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Sunday 17 December 2006 17:51, Sylvain Munaut wrote:
>   
>> The of_platform one has been tested on Efika and enable module
>> autoloading by udev. The macio patch is not tested. However,
>> being based on the same code as the of_platform handler I would
>> excpect it to be fine.
>>     
>
> Would it be possible to have only a single copy of that code,
> for all of_device probes? I guess the same code also will be
> used on ibmebus and the ps3platform bus eventually.
>   
Mmmh. Yes actually,

I could put that code in of_device.c and export it, then in each bus, you
would only need a small stub to handle the conversion to of_device *
and call the common code.

I'll do that and resend.


    Sylvain
