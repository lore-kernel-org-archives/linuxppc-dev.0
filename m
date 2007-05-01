Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 15477DDF33
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 07:03:01 +1000 (EST)
Date: Tue, 1 May 2007 23:03:01 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Stefan Roese <ml@stefan-roese.de>
Subject: Re: Correct location for ADC/DAC drivers
In-Reply-To: <200705011435.45046.ml@stefan-roese.de>
Message-ID: <Pine.LNX.4.60.0705012301500.4972@poirot.grange>
References: <200705011435.45046.ml@stefan-roese.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 1 May 2007, Stefan Roese wrote:

> I'm in the stage of integrating some ADC and DAC drivers for the AMCC 405EZ 
> PPC and looking for the correct location to place these drivers in the Linux 
> source tree. The drivers are basically character-drivers, so my first thought 
> is to put them in "drivers/char/adc/foo.c" or "drivers/char/adc_foo.c". Is 
> this a good solution?

drivers/mfd following ucb1x00?

Thanks
Guennadi
---
Guennadi Liakhovetski
