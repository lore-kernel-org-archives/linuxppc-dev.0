Return-Path: <npiggin@suse.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 32B22B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 20:39:59 +1000 (EST)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id ACA2ADDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2009 20:39:58 +1000 (EST)
Date: Mon, 20 Jul 2009 12:39:44 +0200
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] mm: Pass virtual address to [__]p{te, ud,
	md}_free_tlb()
Message-ID: <20090720103944.GC7070@wotan.suse.de>
References: <20090715074952.A36C7DDDB2@ozlabs.org>
	<20090715135620.GD7298@wotan.suse.de>
	<1248073873.13067.31.camel@pasglop>
	<20090720080502.GG7298@wotan.suse.de>
	<1248083961.30899.5.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1248083961.30899.5.camel@pasglop>
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

On Mon, Jul 20, 2009 at 07:59:21PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2009-07-20 at 10:05 +0200, Nick Piggin wrote:
> > 
> > Unless anybody has other preferences, just send it straight to Linus in
> > the next merge window -- if any conflicts did come up anyway they would
> > be trivial. You could just check against linux-next before doing so, and
> > should see if it is going to cause problems for any arch pull...
> 
> Well, the problem is that powerpc-next will need that patch, which means
> that if I don't put it in my tree, Steven won't be able to build
> powerpc-next as part of linux-next until the patch is merged. Hence my
> question, what's the best way to handle that :-) There isn't an mm-next
> is there ? If there was, I could tell Steven to always pull powerpc
> after mm for example. Or I can put it in a git tree of its own with a
> dependency for Steven to pull.

No I don't think there is an mm-next. But Steven will hold individual
patches to correct intermediate issues like this, won't he?
