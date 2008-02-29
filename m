Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 234B7DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 09:53:34 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1TMrVNF027160
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Feb 2008 17:53:31 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1TMrVpj250354
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Feb 2008 17:53:31 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1TMrVvh004828
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Feb 2008 17:53:31 -0500
Date: Fri, 29 Feb 2008 16:51:37 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Sequoia build with KDBG
Message-ID: <20080229165137.64acbebf@zod.rchland.ibm.com>
In-Reply-To: <200802292230.m1TMUk4I005462@e31.co.us.ibm.com>
References: <20080221213313.97814DDF55@ozlabs.org>
	<20080222164210.48628DE0A9@ozlabs.org>
	<20080222145224.7349cf36@weaponx>
	<200802292133.m1TLXqv3012273@e36.co.us.ibm.com>
	<20080229153534.684aebf9@zod.rchland.ibm.com>
	<200802292230.m1TMUk4I005462@e31.co.us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 29 Feb 2008 17:31:10 -0500
Steve Heflin <sheflin@newagemicro.com> wrote:

> At 04:35 PM 2/29/2008, Josh Boyer wrote:
> >On Fri, 29 Feb 2008 16:34:09 -0500
> >Steve Heflin <sheflin@newagemicro.com> wrote:
> >
> > > I attempted to enable the kernel debugger on my Sequoia board, and I
> > > get build errors:
> > >   /linux-2.6.25-rc3/arch/powerpc/kernel/setup_32.c:254: undefined
> > > reference to `set_debug_traps'
> > >   /linux-2.6.25-rc3/arch/powerpc/kernel/setup_32.c:259: undefined
> > > reference to `breakpoint'
> > >
> > > Josh: I assume you have used the kernel debugger with your 44x
> > > boards, how did you build it?
> >
> >Why would you assume that?  I've never used kgdb on arch/powerpc
> >kernels, nor have I ever tried to build it.
>
> I assumed that because I've always needed a debugger when 
> implementing kernel level components. Since you've implemented kernel 
> level support for several 44x processors, I just assumed that you 
> needed kdbg at some point. So you're saying that your additions 

Nope.  I did the poor man's method of manually poking characters out of
the serial port.

> worked right out of the gate and you never needed a debugger?  You're my hero!

I largely stood on the shoulders of those that came before me.  Porting
has become trivial lately, mostly due to the collective work lots of
people have put in.

That all being said, I'm not opposed to having kgdb work on 4xx.  I
just have never personally looked at it yet.  Patches welcome :).

josh
