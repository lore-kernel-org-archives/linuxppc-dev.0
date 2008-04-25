Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0600EDE189
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 23:03:43 +1000 (EST)
Subject: Re: [RFC][WIP][PATCH] Add IRQSTACKS to ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20080425072332.GB23053@lst.de>
References: <Pine.LNX.4.64.0804240034160.23185@blarg.am.freescale.net>
	<20080425072332.GB23053@lst.de>
Content-Type: text/plain
Date: Fri, 25 Apr 2008 23:03:34 +1000
Message-Id: <1209128614.5420.6.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-04-25 at 09:23 +0200, Christoph Hellwig wrote:
> On Thu, Apr 24, 2008 at 12:37:50AM -0500, Kumar Gala wrote:
> >  config IRQSTACKS
> >  	bool "Use separate kernel stacks when processing interrupts"
> > -	depends on PPC64
> 
> Why do we have this as a user-selectable option?  It should be on by
> default on 32 or 64bit.

History maybe ? In the early days it was a bit "experimental" (we had a
couple of issues that popped up with some thread flags not being
properly recovered etc...). Nowadays, I agree it should not be an
option.

Ben.
