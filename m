Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3858ADDF9B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 05:11:17 +1000 (EST)
Date: Wed, 2 May 2007 20:11:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Correct location for ADC/DAC drivers
Message-ID: <20070502191101.GB16696@flint.arm.linux.org.uk>
References: <200705011435.45046.ml@stefan-roese.de>
	<Pine.LNX.4.60.0705012301500.4972@poirot.grange>
	<200705021225.54417.ml@stefan-roese.de>
	<20070502133512.GK22585@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070502133512.GK22585@pengutronix.de>
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

On Wed, May 02, 2007 at 03:35:12PM +0200, Robert Schwebel wrote:
> On Wed, May 02, 2007 at 12:25:53PM +0200, Stefan Roese wrote:
> > Is there a maintainer for this "drivers/mfd" directory?
> 
> rmk

I wouldn't go that far.  There's no real infrastructure there
to maintain, so I'd actually say that the directory was
maintainerless.  However, I'll own up to the UCB/MCP drivers
in there.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
