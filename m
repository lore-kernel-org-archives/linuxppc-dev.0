Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4952DDE3F
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 00:48:46 +1000 (EST)
Date: Fri, 24 Aug 2007 09:48:37 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH 05/20] bootwrapper: flatdevtree fixes
Message-ID: <20070824144837.GA18753@ld0162-tx32.am.freescale.net>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173949.GD30562@ld0162-tx32.am.freescale.net>
	<20070821023044.GF15469@localhost.localdomain>
	<46CB0E56.2020601@freescale.com>
	<20070822010907.GA12472@localhost.localdomain>
	<20070822172456.GA22932@ld0162-tx32.am.freescale.net>
	<20070823020147.GB7042@localhost.localdomain>
	<46CDC86E.2070907@freescale.com>
	<20070824010122.GA7281@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070824010122.GA7281@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2007 at 11:01:22AM +1000, David Gibson wrote:
> On Thu, Aug 23, 2007 at 12:48:30PM -0500, Scott Wood wrote:
> > It's likely to be ugly no matter what, though I'll try to come up with 
> > something slightly nicer.  If I were doing this code from scratch, I'd 
> > probably liven the tree first and reflatten it to pass to the kernel.
> 
> Eh, probably not worth bothering doing an actual implementation at
> this stage - I'll have to redo it for libfdt anyway.

Too late, I already wrote it -- it wasn't as bad as I thought it would
be.

> flatdevtree uses some of the information it caches in the phandle
> context stuff to remember who's the parent of a node.  libfdt uses raw
> offsets into the structure, so the *only* way to implement
> get_parent() is to rescan the dt from the beginning, keeping track of
> parents until reaching the given node.

What is the benefit of doing it that way?

-Scott
