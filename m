Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD816DDE38
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 00:08:42 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6NE8d0C009312
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 10:08:39 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6NE8dk2210492
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 08:08:39 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6NE8dRG023489
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 08:08:39 -0600
Subject: Re: [PATCH] Use resource_size_t for serial port IO addresses
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20070715110606.GA32577@flint.arm.linux.org.uk>
References: <1184335336.6456.17.camel@weaponx.rchland.ibm.com>
	<20070713120226.797117e2.akpm@linux-foundation.org>
	<20070715110606.GA32577@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 23 Jul 2007 09:08:37 -0500
Message-Id: <1185199717.4268.5.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-07-15 at 12:06 +0100, Russell King wrote:
> > This is something we should do, but I have recollections of Russell
> > identifying problems with this patch, or at least an earlier version of it?
> 
> Basically, there's two patches.  This one (let's call this patch A)
> and another to prevent users being surprised (let's call that patch B).
> 
> I didn't have any real objections to patch A, provided something like
> patch B was merged.  I did have objections against patch B, and I was
> intermittently working on a revised solution.
> 
> However, for whatever reason [*], during the last merge window patch B
> got merged and patch A got dropped, and as a result I've now given up
> with my revised solution, and TBH, I no longer care.

Patch B in this case was commit abb4a2390.  Since that has already been
merged, can we please merge this patch into 2.6.23?  I'd really like to
avoid 44x not working in yet another kernel, so if this patch can't be
merged I'll have to come up with some alternate solution soon.

josh
