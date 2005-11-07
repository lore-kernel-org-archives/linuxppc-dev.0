Return-Path: <SRS0+b070d120c301b1432305+806+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B40C56869E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2005 04:02:59 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20051107165453.GA29111@lst.de>
References: <1131357857.27347.28.camel@baythorne.infradead.org>
	<20051107160939.GD3839@smtp.west.cox.net>
	<1131380422.27347.72.camel@baythorne.infradead.org>
	<20051107165453.GA29111@lst.de>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 17:02:51 +0000
Message-Id: <1131382971.27347.79.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix 8250 probe on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-11-07 at 17:54 +0100, Christoph Hellwig wrote:
> What about putting that into the kernel tree so it can be built as
> part of make boot.  

The mkzimage script? That doesn't make a lot of sense. The whole point
in that is to build the zImage _separately_ from the kernel. The kernel
is already capable of making the zImage by itself as part of the build
process.

Or do you just mean the trivial patch to make arch/ppc64/boot/ capable
of loading a 32-bit kernel? That'll make sense if that code gets moved
to arch/powerpc/boot, and I'll do so then.

-- 
dwmw2
