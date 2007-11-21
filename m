Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6753DDE27
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 06:19:53 +1100 (EST)
Message-Id: <8A7483CD-AF52-46C7-94FD-2CAE53740EC4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20071121173308.GB4413@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 3/3] [POWERPC] Add docs for Freescale DMA & DMA channel
	device tree nodes
Date: Wed, 21 Nov 2007 13:19:43 -0600
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>
	<Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>
	<20071121173308.GB4413@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 21, 2007, at 11:33 AM, Scott Wood wrote:

> On Tue, Nov 20, 2007 at 11:14:40PM -0600, Kumar Gala wrote:
>> +    - compatible        : compatible list, contains 2 entries,  
>> first is
>> +			 "fsl,CHIP-dma", where CHIP is the processor
>> +			 (mpc8540, mpc8540, etc.) and the second is
>> +			 "fsl,eloplus-dma"
>
> So if the DMA register set gets tweaked again, will we have  
> eloplusplus? :-)
> Maybe elo2 would be better.

Seem unlikely for the forseeable future.

> Do we really need completely separate descriptions of the two, or
> can we just describe the difference in the compatible section?

it seemed easier to duplicate and fix.

- k
