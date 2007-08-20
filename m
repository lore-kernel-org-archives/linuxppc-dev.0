Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1F27BDDE2E
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 01:37:25 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7KFbMAc032604
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 11:37:22 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7KFbL1g212914
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 09:37:21 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7KFbLf0028967
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 09:37:21 -0600
Date: Mon, 20 Aug 2007 10:37:19 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/3 v2] Remove need for include/asm-ppc
Message-ID: <20070820103719.23f50f64@weaponx.rchland.ibm.com>
In-Reply-To: <A4E8D00C-87DB-4C59-A6C4-70D437ED9988@kernel.crashing.org>
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
	<20070820060000.GA26100@localhost.localdomain>
	<A4E8D00C-87DB-4C59-A6C4-70D437ED9988@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 20 Aug 2007 10:32:43 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Aug 20, 2007, at 1:00 AM, David Gibson wrote:
> 
> > On Sat, Aug 18, 2007 at 12:05:36PM -0500, Kumar Gala wrote:
> >> This patch series removes the need for include/asm-ppc in the  
> >> ARCH=powerpc
> >> build for ppc32.  They exist in the following git tree:
> >>
> >>   master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
> >> for-2.6.24
> >>
> >> posting here for everyone else to see.
> >>
> >> Updated with changes suggested by Arnd & Segher. (removal 82xx pci  
> >> header
> >> and moving some headers under platforms if not globally needed).
> >
> > Nice!  I'm hoping the next step after this is to do the other way
> > around - make ARCH=ppc builds independent of things in arch/powerpc or
> > include/asm-powerpc, which is almost the more important change.
> 
> Maybe, hadn't thought about that case.  One thing at a time :)
> 
> Do we want to go and move stuff back out of arch/powerpc/kernel back  
> into arch/ppc/kernel?  or just include files?

What would be the point of doing that?  I would think we want the
opposite, in that we want to reuse as much of arch/powerpc during
arch/ppc compiles as possible.  Sort of shows how much is "left" to
port.

Also, making arch/ppc compile stand-alone again would be "wasted" work,
since it's going to die anyway.

josh
