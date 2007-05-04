Return-Path: <ml@stefan-roese.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.162])
	by ozlabs.org (Postfix) with ESMTP id 893DADDF57
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 16:11:25 +1000 (EST)
From: Stefan Roese <ml@stefan-roese.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Correct location for ADC/DAC drivers
Date: Fri, 4 May 2007 08:11:42 +0200
References: <200705011435.45046.ml@stefan-roese.de>
	<20070502133512.GK22585@pengutronix.de>
	<20070502191101.GB16696@flint.arm.linux.org.uk>
In-Reply-To: <20070502191101.GB16696@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705040811.43312.ml@stefan-roese.de>
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 02 May 2007 21:11, Russell King wrote:
> > > Is there a maintainer for this "drivers/mfd" directory?
> >
> > rmk
>
> I wouldn't go that far.  There's no real infrastructure there
> to maintain, so I'd actually say that the directory was
> maintainerless.  However, I'll own up to the UCB/MCP drivers
> in there.

So perhaps you could answer is you feel that these ADC & DAC chrdev device 
drivers would fit into this drivers/mfd directory, or are better suited for 
the drivers/char directory?

Thanks.

Best regards,
Stefan
