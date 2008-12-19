Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8AD61DDEFF
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 09:02:33 +1100 (EST)
Message-ID: <494C10EE.1040305@embedded-sol.com>
Date: Fri, 19 Dec 2008 23:23:58 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
Subject: Re: Long boot delay on 460EX with 2.6.28-rc8
References: <21070179.post@talk.nabble.com>
	<20081218190208.GC18201@yoda.jdub.homelinux.org>
	<21087072.post@talk.nabble.com> <200812190856.19482.sr@denx.de>
In-Reply-To: <200812190856.19482.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Friday 19 December 2008, Felix Radensky wrote:
>   
>> Thanks a lot to everyone who replied. I've managed to identify the cause
>> of the delay. The board is equipped with 256 MiB Samsung NAND flash.
>> Since NAND support is a must for this platform, I've intergated the ndfc
>> driver recently posted by Sean McLennan. With this driver enabled the delay
>> is present, without it messages appear on the console immediately.
>>
>> Is this an expected behavior - detection of 256 MiB NAND flash
>> takes around 20 seconds. The ndfc driver works fine after boot.
>>     
>
> No, 20 seconds is definitely too long. Something must be wrong with the ndfc 
> driver or the NAND dts entries.
>
> Best regards,
> Stefan
>   
Hi, Sean

Do you have any ideas what can cause such delay ?

Thanks.

Felix.
