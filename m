Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 27B56DDED2
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 18:24:37 +1000 (EST)
Date: Fri, 4 May 2007 10:24:34 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Stefan Roese <ml@stefan-roese.de>
Subject: Re: Correct location for ADC/DAC drivers
Message-ID: <20070504082434.GA22585@pengutronix.de>
References: <200705011435.45046.ml@stefan-roese.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200705011435.45046.ml@stefan-roese.de>
Sender: Robert Schwebel <rsc@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 01, 2007 at 02:35:44PM +0200, Stefan Roese wrote:
> I'm in the stage of integrating some ADC and DAC drivers for the AMCC
> 405EZ PPC and looking for the correct location to place these drivers
> in the Linux source tree. The drivers are basically character-drivers,
> so my first thought is to put them in "drivers/char/adc/foo.c" or
> "drivers/char/adc_foo.c". Is this a good solution?
> 
> Any suggestions welcome (could be that I missed an already existing
> example).
> 
> BTW: I am aware of the hwmon subsystem, but I don't think it fits my
> needs in this case.

Could you elaborate the requirements a bit more? ADC is not ADC, because
slow i2c ADCs which measure a temperature every five minutes have other
requirements than multi-megabyte-per-second-dma-driven ADCs.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
