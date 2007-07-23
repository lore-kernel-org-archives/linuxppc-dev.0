Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6D7C3DDE40
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 05:40:14 +1000 (EST)
Date: Mon, 23 Jul 2007 12:34:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Use resource_size_t for serial port IO addresses
Message-Id: <20070723123411.07fc6568.akpm@linux-foundation.org>
In-Reply-To: <1185199717.4268.5.camel@weaponx.rchland.ibm.com>
References: <1184335336.6456.17.camel@weaponx.rchland.ibm.com>
	<20070713120226.797117e2.akpm@linux-foundation.org>
	<20070715110606.GA32577@flint.arm.linux.org.uk>
	<1185199717.4268.5.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Russell King <rmk@arm.linux.org.uk>, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 23 Jul 2007 09:08:37 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Sun, 2007-07-15 at 12:06 +0100, Russell King wrote:
> > > This is something we should do, but I have recollections of Russell
> > > identifying problems with this patch, or at least an earlier version of it?
> > 
> > Basically, there's two patches.  This one (let's call this patch A)
> > and another to prevent users being surprised (let's call that patch B).
> > 
> > I didn't have any real objections to patch A, provided something like
> > patch B was merged.  I did have objections against patch B, and I was
> > intermittently working on a revised solution.
> > 
> > However, for whatever reason [*], during the last merge window patch B
> > got merged and patch A got dropped, and as a result I've now given up
> > with my revised solution, and TBH, I no longer care.
> 
> Patch B in this case was commit abb4a2390.  Since that has already been
> merged, can we please merge this patch into 2.6.23?  I'd really like to
> avoid 44x not working in yet another kernel, so if this patch can't be
> merged I'll have to come up with some alternate solution soon.
> 

I still have a large pile of not-completely-obviously-ready patches to go
through, of which this is one.

There _were_ issues with this patch when it first turned up, but I failed
to record what they were.

Oh well, here's hoping it got fixed.
