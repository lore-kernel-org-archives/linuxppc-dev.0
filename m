Return-Path: <ml@stefan-roese.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.160])
	by ozlabs.org (Postfix) with ESMTP id 18319DDF04
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 20:25:41 +1000 (EST)
From: Stefan Roese <ml@stefan-roese.de>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Correct location for ADC/DAC drivers
Date: Wed, 2 May 2007 12:25:53 +0200
References: <200705011435.45046.ml@stefan-roese.de>
	<Pine.LNX.4.60.0705012301500.4972@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0705012301500.4972@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705021225.54417.ml@stefan-roese.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 01 May 2007 23:03, Guennadi Liakhovetski wrote:
> On Tue, 1 May 2007, Stefan Roese wrote:
> > I'm in the stage of integrating some ADC and DAC drivers for the AMCC
> > 405EZ PPC and looking for the correct location to place these drivers in
> > the Linux source tree. The drivers are basically character-drivers, so my
> > first thought is to put them in "drivers/char/adc/foo.c" or
> > "drivers/char/adc_foo.c". Is this a good solution?
>
> drivers/mfd following ucb1x00?

Perhaps. Not sure though. I just checked again and I still think the drivers 
will better fit for "our" drivers because of the chrdev nature.

Is there a maintainer for this "drivers/mfd" directory?

Thanks.

Best regards,
Stefan
