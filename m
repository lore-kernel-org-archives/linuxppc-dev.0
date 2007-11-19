Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D3D1DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 06:49:55 +1100 (EST)
Subject: Re: [RFC/PATCH 1/9] powerpc: Make isa_mem_base common to 32 and 64
	bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20071119103254.GA19708@lst.de>
References: <1195460700.350036.781662541765.qpush@grosgo>
	<20071119082547.E1455DDE03@ozlabs.org> <20071119103254.GA19708@lst.de>
Content-Type: text/plain
Date: Tue, 20 Nov 2007 06:49:41 +1100
Message-Id: <1195501781.6539.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-11-19 at 11:32 +0100, Christoph Hellwig wrote:
> On Mon, Nov 19, 2007 at 07:25:00PM +1100, Benjamin Herrenschmidt wrote:
> > +/* ISA Memory physical address (or 0 if none) */
> > +resource_size_t isa_mem_base    = 0;
> 
> No need to initialize this.

True. I copy/pasted as-is but you are right, I can remove the
initializer.

Ben.
