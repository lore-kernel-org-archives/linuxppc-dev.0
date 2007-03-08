Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17F00DDE35
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 19:29:54 +1100 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C0DBEA9@zch01exm26.fsl.freescale.net>
References: <1173293364.23776.128.camel@ld0161-tx32>
	<150E096E-0304-4E48-985C-2F4D599196FE@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBE18@zch01exm26.fsl.freescale.net>
	<CFFA5AB3-1C2A-4928-AE40-5BA24694AB09@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C0DBEA9@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CBC312B0-625A-4F25-AF08-AA89C8A21FDC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Better timer and RTC handling for 8641HPCN.
Date: Thu, 8 Mar 2007 02:28:51 -0600
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 8, 2007, at 2:17 AM, Zhang Wei-r63237 wrote:

> Hi, Kumar,
>
>>>
>>> So I reduces it by 10 for IRQs reserved (leave 1 more space for
>>> further).
>>
>> Why don't we set the number to 64 instead of NR_IRQS - 10.  This
>> covers all the internal and external interrupts.
>>
>
> If you want to set the IRQ amount number, it should be 80 instead  
> of 64.
> But I think setting it to NR_IRQS-10 could give more space for MPIC.

Sure, but what's the point in allocating more interrupts than you  
actually will ever have?

I'd say lets make it 64 for now.  We don't yet support the messaging  
or MSI interrupts that exist beyond 64.

- k
