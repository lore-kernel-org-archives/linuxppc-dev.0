Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04C27DDE20
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 19:00:30 +1000 (EST)
Date: Wed, 4 Apr 2007 10:00:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404090016.GC13134@flint.arm.linux.org.uk>
References: <1175666635.2932.17.camel@shinybook.infradead.org>
	<20070404.011208.120446173.davem@davemloft.net>
	<20070404083803.GA13134@flint.arm.linux.org.uk>
	<20070404.014330.91315500.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070404.014330.91315500.davem@davemloft.net>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2007 at 01:43:30AM -0700, David Miller wrote:
> From: Russell King <rmk+lkml@arm.linux.org.uk>
> Date: Wed, 4 Apr 2007 09:38:03 +0100
> 
> > However, despite people pressing for it, there's yet to be a *sane*
> > *technical* *solution* to the problem.  All I've seen so far is one
> > bad hack.
> 
> Well the "bad hack" we use on sparc gives usable serial ports,
> properly ordered and using /dev/ttyS0, with a proper matching
> console selection.

Well yes, but it seems to have code in the architecture's early
command line parsing to parse the "console=" argument to set this
magical "serial_console" variable.

Is this an approach you recommend for all architectures?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
