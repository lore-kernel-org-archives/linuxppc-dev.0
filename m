Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B6EADDF85
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 00:09:42 +1000 (EST)
In-Reply-To: <87ejg8vwhb.fsf@macbook.be.48ers.dk>
References: <87lkakxky1.fsf@macbook.be.48ers.dk>
	<20071004140126.99c0fab0.sfr@canb.auug.org.au>
	<17D08E8E-6ADC-4D61-8859-8329EDD4DC6D@kernel.crashing.org>
	<87ejg8vwhb.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DFEADDCC-CFA9-41D5-A52F-03E143D2355D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsl_spi_init: Support non-QE processors
Date: Mon, 8 Oct 2007 09:09:46 -0500
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


On Oct 6, 2007, at 3:06 PM, Peter Korsgaard wrote:

>>>>>> "Kumar" == Kumar Gala <galak@kernel.crashing.org> writes:
>
>  Kumar> On Oct 3, 2007, at 11:01 PM, Stephen Rothwell wrote:
>
>>> On Wed, 03 Oct 2007 17:43:50 +0200 Peter Korsgaard
>>> <jacmet@sunsite.dk> wrote:
>>>>
>>>> @@ -1220,14 +1220,17 @@ int __init fsl_spi_init(struct
>>>> spi_board_info *board_infos,
>>>> {
>>>> struct device_node *np;
>>>> unsigned int i;
>>>> -	const u32 *sysclk;
>>>> +	const u32 *qe_sysclk = 0, *soc_sysclk = 0;
>>>
>>> Please use NULL when referring to pointers.
>
>  Kumar> Peter, any chance of getting a respin.  I'd like this to go
>  Kumar> into 2.6.24.
>
> Certainly. Sorry for the delay, I have been offline for 2 days
> building my house ..

applied.

No problem, sounds like fun.

If you get a chance can you test my for-2.6.24 board to make SPI is  
functional as you expect.

thanks

- k
