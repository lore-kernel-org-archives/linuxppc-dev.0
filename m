Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 70B5068696
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2005 03:31:52 +1100 (EST)
Date: Mon, 7 Nov 2005 09:31:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Message-ID: <20051107163144.GF3839@smtp.west.cox.net>
References: <1131357857.27347.28.camel@baythorne.infradead.org>
	<20051107160939.GD3839@smtp.west.cox.net>
	<1131380422.27347.72.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1131380422.27347.72.camel@baythorne.infradead.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix 8250 probe on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 07, 2005 at 04:20:22PM +0000, David Woodhouse wrote:
> On Mon, 2005-11-07 at 09:09 -0700, Tom Rini wrote:
> > That depends on what we're going to expect out of arch/powerpc/boot,
> > which I'm talking with Paul about. 
> 
> I'd be quite happy to see the bootloader code kept separate from the
> kernel in future.
> 
> Fedora's ppc64-utils package currently has a 'mkzimage' script and a
> bootloader stub based on what's in arch/ppc64/kernel, but modified to be
> capable of loading 32-bit kernels too. We can quite happily put together
> the stub, the vmlinux and the initrd after the fact.

I've always found it quite handy, and thought it was a good new user
experiance that they could just build and boot the kernel with just the
kernel tarball around.  If everything going forward ships from the hw
vendor with U-Boot, that's less of an issue, but I don't know how likely
!Freescale is to change.

> I don't really see why any of the other stubs necessarily need to live
> with the kernel either.

Avoiding duplication of hardware defines (serial, whack-a-device, etc)
has been part of it.

-- 
Tom Rini
http://gate.crashing.org/~trini/
