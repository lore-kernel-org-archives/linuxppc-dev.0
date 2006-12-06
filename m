Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4A5F67CA5
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 09:12:53 +1100 (EST)
In-Reply-To: <16CEB634-0DC7-438B-973C-2BE5A374591C@freescale.com>
References: <F6AD7E21CDF4E145A44F61F43EE6D939B5008F@tmnt04.transmode.se>
	<16CEB634-0DC7-438B-973C-2BE5A374591C@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <65D63DFC-AC2E-490A-BB3D-32CFE7B026B3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2.6.20] powerpc: Changed gianfar device tree definition
	tomake it more flexible
Date: Wed, 6 Dec 2006 16:12:44 -0600
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 6, 2006, at 2:40 PM, Andy Fleming wrote:

>
> On Dec 4, 2006, at 02:20, Joakim Tjernlund wrote:
>
>>
>>> +
>>> +static struct gfar_flag_info __initdata flag_info[] = {
>>> +	{ "gigabit", FSL_GIANFAR_DEV_HAS_GIGABIT },
>>> +	{ "coalescing", FSL_GIANFAR_DEV_HAS_COALESCE },
>>> +	{ "rmon", FSL_GIANFAR_DEV_HAS_RMON },
>>> +	{ "checksumming", FSL_GIANFAR_DEV_HAS_CSUM },
>>> +	{ "vlan", FSL_GIANFAR_DEV_HAS_VLAN },
>>> +	{ "extended-hash", FSL_GIANFAR_DEV_HAS_EXTENDED_HASH },
>>> +	{ "padding", FSL_GIANFAR_DEV_HAS_PADDING },
>>> +	{ "filer", FSL_GIANFAR_DEV_HAS_FILER },
>>> +	{ "parseL4", FSL_GIANFAR_DEV_HAS_PARSE_L4 },
>>> +	{ "parseL3", FSL_GIANFAR_DEV_HAS_PARSE_L3 },
>>> +	{ "parseL2", FSL_GIANFAR_DEV_HAS_PARSE_L2 },
>>> +	{ "multi-queue", FSL_GIANFAR_DEV_HAS_MULTI_QUEUE },
>>> +	{ "buffer-stashing", FSL_GIANFAR_DEV_HAS_BUF_STASHING },
>>> +	{ "buffer-locking", FSL_GIANFAR_DEV_HAS_BUF_LOCKING },
>>> +	{ "bd-stashing", FSL_GIANFAR_DEV_HAS_BD_STASHING },
>>> +	{ "bd-locking", FSL_GIANFAR_DEV_HAS_BD_LOCKING },
>>> +};
>>
>> Shouldn't these be  mapped to generic names(drop the GIANFAR name)?
>> The newer UCC also have sevral of these capabilities and it seems
>> to me that one can use the same names instead of making a similar  
>> table.
>
>
> That's an excellent idea.  But the UCC code base is still pretty  
> foreign to me, so I will have to pursue that with its authors.

Unless we plan on merging the UCC and gianfar drivers in the future I  
dont see much of a point to worry about it.  Eventually this table  
will live in the driver proper so it will have to be duplicated  
between gianfar and UCC.

- k
