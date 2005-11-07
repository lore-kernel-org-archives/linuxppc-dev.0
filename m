Return-Path: <SRS0+b070d120c301b1432305+806+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C36B68593
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2005 03:20:29 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20051107160939.GD3839@smtp.west.cox.net>
References: <1131357857.27347.28.camel@baythorne.infradead.org>
	<20051107160939.GD3839@smtp.west.cox.net>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 16:20:22 +0000
Message-Id: <1131380422.27347.72.camel@baythorne.infradead.org>
Mime-Version: 1.0
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

On Mon, 2005-11-07 at 09:09 -0700, Tom Rini wrote:
> That depends on what we're going to expect out of arch/powerpc/boot,
> which I'm talking with Paul about. 

I'd be quite happy to see the bootloader code kept separate from the
kernel in future.

Fedora's ppc64-utils package currently has a 'mkzimage' script and a
bootloader stub based on what's in arch/ppc64/kernel, but modified to be
capable of loading 32-bit kernels too. We can quite happily put together
the stub, the vmlinux and the initrd after the fact.

I don't really see why any of the other stubs necessarily need to live
with the kernel either.

-- 
dwmw2
