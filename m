Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B34C68692
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2005 03:55:04 +1100 (EST)
Date: Mon, 7 Nov 2005 17:54:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Woodhouse <dwmw2@infradead.org>
Message-ID: <20051107165453.GA29111@lst.de>
References: <1131357857.27347.28.camel@baythorne.infradead.org>
	<20051107160939.GD3839@smtp.west.cox.net>
	<1131380422.27347.72.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1131380422.27347.72.camel@baythorne.infradead.org>
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

On Mon, Nov 07, 2005 at 04:20:22PM +0000, David Woodhouse wrote:
> Fedora's ppc64-utils package currently has a 'mkzimage' script and a
> bootloader stub based on what's in arch/ppc64/kernel, but modified to be
> capable of loading 32-bit kernels too. We can quite happily put together
> the stub, the vmlinux and the initrd after the fact.

What about putting that into the kernel tree so it can be built as part
of make boot.  
