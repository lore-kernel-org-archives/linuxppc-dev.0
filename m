Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C724DDE1D
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 00:11:14 +1000 (EST)
In-Reply-To: <20071004140126.99c0fab0.sfr@canb.auug.org.au>
References: <87lkakxky1.fsf@macbook.be.48ers.dk>
	<20071004140126.99c0fab0.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <17D08E8E-6ADC-4D61-8859-8329EDD4DC6D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsl_spi_init: Support non-QE processors
Date: Fri, 5 Oct 2007 09:11:12 -0500
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2007, at 11:01 PM, Stephen Rothwell wrote:

> On Wed, 03 Oct 2007 17:43:50 +0200 Peter Korsgaard  
> <jacmet@sunsite.dk> wrote:
>>
>> @@ -1220,14 +1220,17 @@ int __init fsl_spi_init(struct  
>> spi_board_info *board_infos,
>>  {
>>  	struct device_node *np;
>>  	unsigned int i;
>> -	const u32 *sysclk;
>> +	const u32 *qe_sysclk = 0, *soc_sysclk = 0;
>
> Please use NULL when referring to pointers.

Peter, any chance of getting a respin.  I'd like this to go into 2.6.24.

- k
