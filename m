Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63C57DDDF9
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 18:29:58 +1100 (EST)
Subject: Re: Powerpc PCI cleanups (mainly iSeries)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071206094448.4de7967a@zod.rchland.ibm.com>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
	<20071207020726.8c0ea12b.sfr@canb.auug.org.au>
	<20071206094448.4de7967a@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sun, 09 Dec 2007 18:29:26 +1100
Message-Id: <1197185366.6572.43.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-12-06 at 09:44 -0600, Josh Boyer wrote:
> On Fri, 7 Dec 2007 02:07:26 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > On Thu, 6 Dec 2007 18:00:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > I started out looking for ways to remove our dependencies on pci_dn and
> > > got sidetracked into clening up the iSeries PCI code.  The intention of
> > > the following set of patches is that there be no semantic changes
> > > (mostly).
> > 
> > Some of these will clearly conflict with Benh's PCI work.  We will sot
> > that out between us.  :-)
> 
> In the meantime...
> 
> My tree is going to carry BenH's patches since they're obviously
> important to 4xx.  If these conflicts get sorted out soon, that would
> be good :).  At some point I'm going to start sending stuff to Paul.

The PCI merge serie of my patches shoudn't go through your tree (it's a
separate serie from my 4xx stuff and isn't quite ready just yet...).

I'll sync with Stephen.

Cheers,
Ben.
