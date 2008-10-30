Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92743DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 08:35:53 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9ULZ5rq022003
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 15:35:05 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9ULZn0L148658
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 15:35:49 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9ULZnjv008301
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 15:35:49 -0600
Subject: Re: 2.6.28-rc1: NVRAM being corrupted on ppc64 preventing boot
	(bisected)
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081030210522.GA6532@yoda.jdub.homelinux.org>
References: <alpine.LFD.2.00.0810232028500.3287@nehalem.linux-foundation.org>
	<20081030142632.GA15645@csn.ul.ie>
	<18698.7794.500191.189515@cargo.ozlabs.ibm.com>
	<20081030210522.GA6532@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Thu, 30 Oct 2008 16:35:47 -0500
Message-Id: <1225402547.3322.29.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-30 at 17:05 -0400, Josh Boyer wrote:
> On Fri, Oct 31, 2008 at 07:52:02AM +1100, Paul Mackerras wrote:
> >Mel Gorman writes:
> >
> >> On some ppc64 machines, NVRAM is being corrupted very early in boot (before
> >> console is initialised). The machine reboots and then fails to find yaboot
> >> printing the error "PReP-BOOT: Unable to load PRep image". 
...
> >Eek!
> >
> >Which ppc64 machines has this been seen on, and how were they being
> >booted (netboot, yaboot, etc.)?
> >
> >Is it just the Powerstations with their SLOF-based firmware, or is it
> >IBM pSeries machines as well?
> 
> I'm pretty sure it was with pSeries machines.  I saw reports of POWER5
> being effected (p520 and p710).  I believe one of them resolved the
> issue by upgrading firmware on the machine.

This is true of a p720 (CHRP IBM,9124-720) that I was testing on.  With
upgraded firmware, the problem is gone.

-- 
David Kleikamp
IBM Linux Technology Center
