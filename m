Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BBB66DDF63
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 06:30:12 +1000 (EST)
Message-Id: <E82C3C5F-0D93-4190-ADDC-3FA37D13E250@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: Rick Jones <rick.jones2@hp.com>
In-Reply-To: <4820BA72.3090903@hp.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [RFC] gianfar: low gigabit throughput
Date: Tue, 6 May 2008 15:29:06 -0500
References: <20080506192008.GA30148@polina.dev.rtsoft.ru>
	<4820BA72.3090903@hp.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>
>> I've tried to tune gianfar driver in various ways... and it gave
>> some positive results with this patch:
>> diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
>> index fd487be..b5943f9 100644
>> --- a/drivers/net/gianfar.h
>> +++ b/drivers/net/gianfar.h
>> @@ -123,8 +123,8 @@ extern const char gfar_driver_version[];
>> #define GFAR_10_TIME    25600
>>  #define DEFAULT_TX_COALESCE 1
>> -#define DEFAULT_TXCOUNT	16
>> -#define DEFAULT_TXTIME	21
>> +#define DEFAULT_TXCOUNT	80
>> +#define DEFAULT_TXTIME	105
>>  #define DEFAULT_RXTIME	21
>
> No ethtool coalescing tuning support for gianfar?-)

Yeah, there's coalescing tuning in gianfar.

Anton, those numbers aren't too surprising on a 400 MHz machine, I  
think.  But I'd be happy to see any analysis on performance  
bottlenecks in the driver.  And patches to fix those bottlenecks are  
even better!  :)

Andy
