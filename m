Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75ABE67BBD
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 00:21:16 +1100 (EST)
Date: Sat, 4 Nov 2006 14:21:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Refactor 64 bits DMA operations
Message-ID: <20061104132101.GA8704@lst.de>
References: <1162588895.10630.112.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1162588895.10630.112.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 04, 2006 at 08:21:34AM +1100, Benjamin Herrenschmidt wrote:
> This is also something I'll need in 2.6.20. Right now posted only for
> comments though. It's known to "miss" fixup of at least pasemi and maybe
> a few other things and I've not tested if I break 32 bits build yet :)
> 
> This patch completely refactors DMA operations for 64 bits powerpc. 32 bits
> is untouched for now.

Can we please make 32bit use the same scheme for consistancy?  It would
just plug in a set of dummy direct mapped ops, quite similar to what we
do in Cell (just without setting the magic bit)
