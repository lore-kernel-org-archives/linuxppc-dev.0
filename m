Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3808DDF06
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 17:45:14 +1000 (EST)
Date: Fri, 4 May 2007 08:44:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Stefan Roese <ml@stefan-roese.de>
Subject: Re: Correct location for ADC/DAC drivers
Message-ID: <20070504074453.GA18212@flint.arm.linux.org.uk>
References: <200705011435.45046.ml@stefan-roese.de>
	<20070502133512.GK22585@pengutronix.de>
	<20070502191101.GB16696@flint.arm.linux.org.uk>
	<200705040811.43312.ml@stefan-roese.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705040811.43312.ml@stefan-roese.de>
Sender: Russell King <rmk@arm.linux.org.uk>
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

On Fri, May 04, 2007 at 08:11:42AM +0200, Stefan Roese wrote:
> On Wednesday 02 May 2007 21:11, Russell King wrote:
> > > > Is there a maintainer for this "drivers/mfd" directory?
> > >
> > > rmk
> >
> > I wouldn't go that far.  There's no real infrastructure there
> > to maintain, so I'd actually say that the directory was
> > maintainerless.  However, I'll own up to the UCB/MCP drivers
> > in there.
> 
> So perhaps you could answer is you feel that these ADC & DAC chrdev device 
> drivers would fit into this drivers/mfd directory, or are better suited for 
> the drivers/char directory?

No idea; firstly I've long since deleted the email, secondly I've not much
interest in the directory itself, and thirdly I've enough patches to review
already.  Finally, I'm out all day today, including the evening.  I doubt
I'll read any further email until the weekend.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
