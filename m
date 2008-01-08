Return-Path: <rsc@pengutronix.de>
Date: Tue, 8 Jan 2008 17:11:20 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: Generic MMC-over-SPI binding?
Message-ID: <20080108161120.GC3177@pengutronix.de>
References: <47838708.5050008@hogyros.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <47838708.5050008@hogyros.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 03:22:00PM +0100, Simon Richter wrote:
> in an embedded system similar to the lite5200 board, there is an MMC 
> card socket connected to one of the PSCs. Ideally, I'd like to express 
> this fact via the device tree and have the kernel bind the mmc-spi 
> driver to the SPI interface, but I cannot find any place where to insert 
> this code that I feel comfortable with.
> 
>   - It is not a board-specific thing, because any board can just use any 
> SPI bus for MMC.
> 
>   - The mmc-spi driver appears to be platform independent, so I'm not 
> sure OF bindings should be added to it.
> 
>   - The generic device tree scanning does not contain any special cases 
> yet, so I don't want to add one.
> 
> My current thought is to create a new driver that just handles MMC on 
> PSCs in SPI mode by gluing all the relevant drivers together, but that 
> doesn't seem optimal to me either.

You know this driver?

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/mmc/host/mmc_spi.c;h=365024b83d3da9df9b6e4f7a9d4cf6d216ba523d;hb=HEAD

Or is your question how to express this in the device tree?

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
