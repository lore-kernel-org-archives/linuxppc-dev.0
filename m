Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCE98DDE02
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 19:28:46 +1000 (EST)
In-Reply-To: <200708021447.22028.david-b@pacbell.net>
References: <20070802142641.GA6309@localhost.localdomain>
	<200708021447.22028.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <595EE3AF-CDD6-4260-83D9-A3FA3EA1DF95@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] [PATCH] [SPI][POWERPC] spi_mpc83xx: in "QE
	mode" spiclk is sysclk/2
Date: Fri, 3 Aug 2007 04:29:48 -0500
To: David Brownell <david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 2, 2007, at 4:47 PM, David Brownell wrote:

> On Thursday 02 August 2007, Anton Vorontsov wrote:
>> Probably someday mpc83xx_spi->sysclk should be renamed to
>> mpc83xx_spi->spiclk to be less confusing.
>
> Why not "today", with this patch?  That would fix some of
> the root cause of this bug...

I'm fine with this as well.  I just called it sysclk to start with  
since when I wrote the driver it was just for the MPC834x.

- k
