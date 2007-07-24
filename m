Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38290DDECC
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 11:58:01 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6O2LNp2152158
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 12:21:23 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6O21We0142632
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 12:01:33 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6O1vxpe013520
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 11:58:00 +1000
Date: Tue, 24 Jul 2007 11:57:43 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Use resource_size_t for serial port IO addresses
Message-ID: <20070724015743.GD28577@localhost.localdomain>
References: <1184335336.6456.17.camel@weaponx.rchland.ibm.com>
	<20070713120226.797117e2.akpm@linux-foundation.org>
	<20070715110606.GA32577@flint.arm.linux.org.uk>
	<1185199717.4268.5.camel@weaponx.rchland.ibm.com>
	<20070723123411.07fc6568.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070723123411.07fc6568.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, Russell King <rmk@arm.linux.org.uk>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 23, 2007 at 12:34:11PM -0700, Andrew Morton wrote:
> On Mon, 23 Jul 2007 09:08:37 -0500
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> 
> > On Sun, 2007-07-15 at 12:06 +0100, Russell King wrote:
> > > > This is something we should do, but I have recollections of Russell
> > > > identifying problems with this patch, or at least an earlier version of it?
> > > 
> > > Basically, there's two patches.  This one (let's call this patch A)
> > > and another to prevent users being surprised (let's call that patch B).
> > > 
> > > I didn't have any real objections to patch A, provided something like
> > > patch B was merged.  I did have objections against patch B, and I was
> > > intermittently working on a revised solution.
> > > 
> > > However, for whatever reason [*], during the last merge window patch B
> > > got merged and patch A got dropped, and as a result I've now given up
> > > with my revised solution, and TBH, I no longer care.
> > 
> > Patch B in this case was commit abb4a2390.  Since that has already been
> > merged, can we please merge this patch into 2.6.23?  I'd really like to
> > avoid 44x not working in yet another kernel, so if this patch can't be
> > merged I'll have to come up with some alternate solution soon.
> > 
> 
> I still have a large pile of not-completely-obviously-ready patches to go
> through, of which this is one.
> 
> There _were_ issues with this patch when it first turned up, but I failed
> to record what they were.

Heh.  Nor did I ever hear what they might be.

> 
> Oh well, here's hoping it got fixed.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
