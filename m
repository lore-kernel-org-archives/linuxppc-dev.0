Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2D048DDF4B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 09:33:16 +1100 (EST)
Date: Thu, 20 Dec 2007 16:39:44 -0600
From: Olof Johansson <olof@lixom.net>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20071220223943.GA24138@lixom.net>
References: <11981089894052-git-send-email-timur@freescale.com>
	<20071220040633.GA6732@lixom.net> <476A7B23.2040905@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <476A7B23.2040905@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 20, 2007 at 08:24:35AM -0600, Timur Tabi wrote:
> Olof Johansson wrote:
> 
> >> +static struct of_device_id mpc8610_ids[] = {
> >> +	{ .type = "soc", },
> >> +	{}
> > 
> > Please scan based on compatible instead of device_type.
> 
> I was just following the example from another board file.  However, the 'soc' 
> node in the device tree does not have a compatible property, so I don't how to 
> change this.

Then add an appropriate compatible entry to it, please.

> > Do you ever anticipate having other dma users on the system, such as
> > memcpy offload? You'll probably need allocation support for channels
> > when that day comes (I ended up writing a simple library for dma channel
> > management for that very reason on my platform).
> 
> Yes, I plan on updating this driver to work with the standard Freescale "Elo" 
> device driver, but that will have to wait until that code is in the kernel and 
> stabilized.  The SSI is limited in which DMA channels it can use, anyway.

Ok.


-Olof
