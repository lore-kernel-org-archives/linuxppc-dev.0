Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15630DDE08
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 13:43:11 +1000 (EST)
Date: Mon, 20 Aug 2007 21:47:30 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH 0/3 v2] Remove need for include/asm-ppc
Message-ID: <20070820214730.1b3b6fd6@vader.jdub.homelinux.org>
In-Reply-To: <20070821014707.GA15469@localhost.localdomain>
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
	<20070820060000.GA26100@localhost.localdomain>
	<A4E8D00C-87DB-4C59-A6C4-70D437ED9988@kernel.crashing.org>
	<20070820103719.23f50f64@weaponx.rchland.ibm.com>
	<46C9B6DF.1000006@freescale.com>
	<20070821014707.GA15469@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 21 Aug 2007 11:47:07 +1000
David Gibson <dwg@au1.ibm.com> wrote:

> On Mon, Aug 20, 2007 at 10:44:31AM -0500, Scott Wood wrote:
> > Josh Boyer wrote:
> > > On Mon, 20 Aug 2007 10:32:43 -0500
> > > Kumar Gala <galak@kernel.crashing.org> wrote:
> > >>Do we want to go and move stuff back out of arch/powerpc/kernel
> > >>back into arch/ppc/kernel?  or just include files?
> > > 
> > > 
> > > What would be the point of doing that?  I would think we want the
> > > opposite, in that we want to reuse as much of arch/powerpc during
> > > arch/ppc compiles as possible.  Sort of shows how much is "left"
> > > to port.
> > 
> > The point would be to keep the two trees separate, so that one
> > doesn't need to worry about breaking arch/ppc when making a change
> > to arch/powerpc.
> 
> Exactly so.  Having to be careful about not breaking arch/ppc when
> doing cleanups for arch/powerpc is a pain in the bum.

How many times has that happened recently?  If it's fairly infrequent,
then just do the split when you're doing the arch/powerpc cleanup.  I'm
still not convinced that doing a wholesale split again is worth the
effort.

But then again, I'm not opposed either.  Particularly if someone else
is doing the work :).  It simply doesn't make tons of sense to my
feeble little brain.  Seems like that time could be spent better
elsewhere.

josh
