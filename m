Return-Path: <sonny@kevlar.burdell.org>
Received: from kevlar.burdell.org (kevlar.burdell.org [66.92.73.214])
	by ozlabs.org (Postfix) with ESMTP id CBB7067C2C
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 05:27:34 +1000 (EST)
Date: Fri, 9 Jun 2006 15:03:30 -0400
From: Sonny Rao <sonny@burdell.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: oprofile support for POWER6
Message-ID: <20060609190330.GA15890@kevlar.burdell.org>
References: <20060607012359.D59C467B37@ozlabs.org>
	<4AE0F2C6-99B7-40AF-AB28-71D51C1141A5@kernel.crashing.org>
	<20060608042915.C568867B1A@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060608042915.C568867B1A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 08, 2006 at 02:29:01PM +1000, Michael Neuling wrote:
> > >  	/*
> > > -	 * SIHV / SIPR bits are only implemented on POWER4+ (GQ) and above.
> > > -	 * However we disable it on all POWER4 until we verify it works
> > > -	 * (I was seeing some strange behaviour last time I tried).
> > > -	 *
> > > -	 * It has been verified to work on POWER5 so we enable it there.
> > > -	 */
> > 
> > The patched code doesn't handle GQ at all.  Is this on purpose?  Add a
> > similar comment to the CPU feature tables perhaps?
> 
> Yeah, those bits are bust on POWER4+.  We didn't touch them previously
> and we still don't with this patch.
> 
> You're right, we should keep that comment. I'll update and retransmit.

I'm pretty sure SIHV is busted on GQ for sure

Sonny
