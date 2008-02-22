Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10004DE057
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 03:28:48 +1100 (EST)
Date: Fri, 22 Feb 2008 10:28:21 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] Add support for binary includes.
Message-ID: <20080222162821.GC19571@ld0162-tx32.am.freescale.net>
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<fa686aa40802212205p38c3793bg8793740955b1e91@mail.gmail.com>
	<20080222160820.GA19571@ld0162-tx32.am.freescale.net>
	<E1JSahk-0003ub-Eh@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1JSahk-0003ub-Eh@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 22, 2008 at 10:24:56AM -0600, Jon Loeliger wrote:
> So, like, the other day Scott Wood mumbled:
> > > 
> > > Can I ask; what is the intended usage of such a thing?  How large
> > > would a typical binary blob be?
> > 
> > I use it for embedding guest device trees in a hypervisor's device tree.
> 
> Why wouldn't we instead, say, extend the source sytax
> to allow a sub-tree or an embedded tree, rather than
> obscuring an opaque form of that guest device tree?

That was what I tried initially, but the implementation was much more
complicated, and path references are problematic.

-Scott
