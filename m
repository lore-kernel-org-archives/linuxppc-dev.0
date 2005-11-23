Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F57A687E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 05:41:56 +1100 (EST)
In-Reply-To: <20051123125326.GB4526@logos.cnet>
References: <437E048B.2020605@dev.rtsoft.ru> <20051123125326.GB4526@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F0256F16-1169-42DC-B01B-E866114ABB68@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 23 Nov 2005 12:42:39 -0600
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Vitaly Bordug <vbordug@dev.rtsoft.ru>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx PCMCIA: support for MPC885ADS and MPC866ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 23, 2005, at 6:53 AM, Marcelo Tosatti wrote:

> Hi Vitaly,
>
> On Fri, Nov 18, 2005 at 07:42:51PM +0300, Vitaly Bordug wrote:
>> This adds adds PCMCIA supported for  both MPC885ADS and MPC866ADS.
>>
>> This is established not together with FADS, because 885 does not have
>> io_block_mapping() for BCSR area.
>> Also, some cleanups done both for 885ADS and MBX.
>>
>> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
>
> <snip>
>
>> +	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
>
> Shouldnt you handle ioremap() failure? Most 85xx code written
> by Kumar also does not.

Ok, I'll take a hint to go audit my code for ioremap() returns :)

- kumar
