Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0E47DDE1A
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 04:53:37 +1100 (EST)
Message-Id: <6F051FC3-3DDF-4EFF-ACCC-03CE969D0C55@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wim Van Sebroeck <wim@iguana.be>
In-Reply-To: <20090318173547.GF7571@infomag.iguana.be>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v3 1/2] powerpc/86xx: Board support for GE Fanuc's PPC9A
Date: Wed, 18 Mar 2009 12:53:18 -0500
References: <20090318122501.25609.11105.stgit@ubuntu8041.localdomain>
	<20090318122914.25609.765.stgit@ubuntu8041.localdomain>
	<20090318173547.GF7571@infomag.iguana.be>
Cc: linuxppc-dev@ozlabs.org, Martyn Welch <martyn.welch@gefanuc.com>,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 18, 2009, at 12:35 PM, Wim Van Sebroeck wrote:

> Hi Martyn,
>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index c7352f7..ecf52e4 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -772,7 +772,7 @@ config TXX9_WDT
>>
>> config GEF_WDT
>> 	tristate "GE Fanuc Watchdog Timer"
>> -	depends on GEF_SBC610 || GEF_SBC310
>> +	depends on GEF_SBC610 || GEF_SBC310 || GEF_PPC9A
>> 	---help---
>> 	  Watchdog timer found in a number of GE Fanuc single board  
>> computers.
>
> This part is Signed-off-by me. The rest I leave up to the powerpc  
> maintainers.
>
> Kind regards,
> Wim.

Ok w/me adding an actually signed-of-by for you when I apply this?

- k
