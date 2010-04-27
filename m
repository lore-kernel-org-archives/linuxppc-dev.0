Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6AEBFB7D59
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 20:02:38 +1000 (EST)
Date: Tue, 27 Apr 2010 10:54:41 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for ALSA SoC
	drivers
Message-ID: <20100427095440.GA15492@rakim.wolfsonmicro.main>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272350168.24542.6.camel@pasglop>
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 27, 2010 at 04:36:08PM +1000, Benjamin Herrenschmidt wrote:

> Gross. Loses the linkage to device-tree etc... which is useful for audio
> especially. You should at least make sure the device node follows for
> the target driver to be able to use it :-) I'd like you to sync with
> Grant work on that matter if you are going to convert of_devices into
> platform_devices.

So, Liam already sent a message explaining the technical side of this -
the audio subsystem needs to glue together two or more components that
don't immediately have anything to do with each other from a device tree
point of view and may have rather complex interrelationships.

I'd just like to add that I *really* want to see you guys come to some
sort of firm and documented conclusion about the way to handle
situations like this.  Some variant of this seems to come up every
single time anyone tries to do anything to do with audio on a system
using the device tree and it's getting really repetitive.  What would be
really useful for audio at this point would be if we could get some sort
of decision about how to represent this stuff which we can point people
at so that work on systems using the device tree can be done without
having to deal with the device tree layout discussions that frequently
seem to be involved.
