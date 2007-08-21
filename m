Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03082DDDCA
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 12:20:23 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l7L1qRtW6267012
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 11:52:27 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7L1rX2D152990
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 11:53:33 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7L1nxdo000423
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 11:50:00 +1000
Date: Tue, 21 Aug 2007 11:47:07 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 0/3 v2] Remove need for include/asm-ppc
Message-ID: <20070821014707.GA15469@localhost.localdomain>
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
	<20070820060000.GA26100@localhost.localdomain>
	<A4E8D00C-87DB-4C59-A6C4-70D437ED9988@kernel.crashing.org>
	<20070820103719.23f50f64@weaponx.rchland.ibm.com>
	<46C9B6DF.1000006@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46C9B6DF.1000006@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2007 at 10:44:31AM -0500, Scott Wood wrote:
> Josh Boyer wrote:
> > On Mon, 20 Aug 2007 10:32:43 -0500
> > Kumar Gala <galak@kernel.crashing.org> wrote:
> >>Do we want to go and move stuff back out of arch/powerpc/kernel back  
> >>into arch/ppc/kernel?  or just include files?
> > 
> > 
> > What would be the point of doing that?  I would think we want the
> > opposite, in that we want to reuse as much of arch/powerpc during
> > arch/ppc compiles as possible.  Sort of shows how much is "left" to
> > port.
> 
> The point would be to keep the two trees separate, so that one
> doesn't need to worry about breaking arch/ppc when making a change
> to arch/powerpc.

Exactly so.  Having to be careful about not breaking arch/ppc when
doing cleanups for arch/powerpc is a pain in the bum.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
