Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 271F0DDDE7
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 01:44:08 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB9Ei39t023933
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 09:44:03 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB9Ei2r5113942
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 09:44:02 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB9Ei2lo020449
	for <linuxppc-dev@ozlabs.org>; Sun, 9 Dec 2007 09:44:02 -0500
Date: Sun, 9 Dec 2007 08:40:33 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: Powerpc PCI cleanups (mainly iSeries)
Message-ID: <20071209084033.2a3ae963@zod.rchland.ibm.com>
In-Reply-To: <1197185366.6572.43.camel@pasglop>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
	<20071207020726.8c0ea12b.sfr@canb.auug.org.au>
	<20071206094448.4de7967a@zod.rchland.ibm.com>
	<1197185366.6572.43.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 09 Dec 2007 18:29:26 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Thu, 2007-12-06 at 09:44 -0600, Josh Boyer wrote:
> > On Fri, 7 Dec 2007 02:07:26 +1100
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > > On Thu, 6 Dec 2007 18:00:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > I started out looking for ways to remove our dependencies on pci_dn and
> > > > got sidetracked into clening up the iSeries PCI code.  The intention of
> > > > the following set of patches is that there be no semantic changes
> > > > (mostly).
> > > 
> > > Some of these will clearly conflict with Benh's PCI work.  We will sot
> > > that out between us.  :-)
> > 
> > In the meantime...
> > 
> > My tree is going to carry BenH's patches since they're obviously
> > important to 4xx.  If these conflicts get sorted out soon, that would
> > be good :).  At some point I'm going to start sending stuff to Paul.
> 
> The PCI merge serie of my patches shoudn't go through your tree (it's a
> separate serie from my 4xx stuff and isn't quite ready just yet...).

I wasn't talking about your series of 10 patches.  You'll have
conflicts in your series of 25 too, though those should be fairly minor.

josh
