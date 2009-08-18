Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3DA0CB7C7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 08:33:42 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9776FDDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 08:33:41 +1000 (EST)
Subject: Re: [PATCH/RFC] powerpc/mm: Cleanup handling of execute permission
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090818205621.GB2530@zod.rchland.ibm.com>
References: <1248766373.30993.50.camel@pasglop>
	<FBB5798A-EE85-4B18-8883-F6182B203996@kernel.crashing.org>
	<20090818205621.GB2530@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 19 Aug 2009 08:33:20 +1000
Message-Id: <1250634800.4810.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-08-18 at 16:56 -0400, Josh Boyer wrote:
> On Fri, Aug 14, 2009 at 05:39:42PM -0500, Becky Bruce wrote:
> > Ben,
> >
> > This breaks the boot on 8572.  I don't know why yet (and I'm probably  
> > not going to figure it out before I go home, because, frankly, it's late 
> > on a Friday afternoon and I need a glass of wine or, perhaps, a beer).
> >
> > Kumar and I will poke into this more and let you know what we find out - 
> > in the meantime, if you have any brilliant flashes, pony up!
> 
> I tested this on a 440EPx NFS rootfs boot too.  It doesn't cause init itself
> to crap out with a SIGILL like Becky's board, but it does do weird things
> and cause a SIGILL elsewhere during my boot.
> 
> Reverting this patch from your testing branch allows things to work just fine.

Becky found my thinko, I'll send a new patch later today.

Cheers,
Ben.
