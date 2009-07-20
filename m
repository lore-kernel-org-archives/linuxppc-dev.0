Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DE466B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 17:11:30 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 348B7DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2009 17:11:29 +1000 (EST)
Subject: Re: [RFC/PATCH] mm: Pass virtual address to [__]p{te,ud,md}_free_tlb()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20090715135620.GD7298@wotan.suse.de>
References: <20090715074952.A36C7DDDB2@ozlabs.org>
	<20090715135620.GD7298@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 20 Jul 2009 17:11:13 +1000
Message-Id: <1248073873.13067.31.camel@pasglop>
Mime-Version: 1.0
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Hugh Dickins <hugh@tiscali.co.uk>, linux-kernel@vger.kernel.org,
	Linux Memory Management <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-07-15 at 15:56 +0200, Nick Piggin wrote:
> > I would like to merge the new support that depends on this in 2.6.32,
> > so unless there's major objections, I'd like this to go in early during
> > the merge window. We can sort out separately how to carry the patch
> > around in -next until then since the powerpc tree will have a dependency
> > on it.
> 
> Can't see any problem with that.

CC'ing Linus here. How do you want to proceed with that merge ? (IE. so
far nobody objected to the patch itself)

IE. The patch affects all archs, though it's a trivial change every
time, but I'll have stuff in powerpc-next that depends on it, and so I'm
not sure what the right approach is here. Should I put it in the powerpc
tree ?

I also didn't have any formal Ack from anybody, neither mm folks nor
arch maintainers :-)

Cheers,
Ben.
