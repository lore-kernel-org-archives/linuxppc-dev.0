Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 476DADDF11
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 07:50:08 +1000 (EST)
In-Reply-To: <A02128B3-41EE-47AA-802F-C0E3400411FB@kernel.crashing.org>
References: <20070613045256.B35E1DDECA@ozlabs.org>
	<A02128B3-41EE-47AA-802F-C0E3400411FB@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <47CD4FAA-B7E6-4ED4-A6A3-9865577A88B9@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 5/13] Remove a couple of unused definitions from
	pgtable_32.c
Date: Thu, 14 Jun 2007 16:50:06 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 14, 2007, at 16:04, Kumar Gala wrote:

>
> On Jun 12, 2007, at 11:52 PM, David Gibson wrote:
>>
>> -/* is x a power of 4? */
>> -#define is_power_of_4(x)	is_power_of_2(x) && (ffs(x) & 1)
>> -
>
> is_power_of_4 is used by HAVE_TLBCAM, why are you killing it?


He removed io_block_mapping() in patch #3

Andy
