Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B332DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 09:30:45 +1100 (EST)
Date: Fri, 29 Feb 2008 17:31:10 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Sequoia build with KDBG
In-Reply-To: <20080229153534.684aebf9@zod.rchland.ibm.com>
References: <20080221213313.97814DDF55@ozlabs.org>
	<20080222164210.48628DE0A9@ozlabs.org>
	<20080222145224.7349cf36@weaponx>
	<200802292133.m1TLXqv3012273@e36.co.us.ibm.com>
	<20080229153534.684aebf9@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080229223046.1B332DDE0A@ozlabs.org>
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

At 04:35 PM 2/29/2008, Josh Boyer wrote:
>On Fri, 29 Feb 2008 16:34:09 -0500
>Steve Heflin <sheflin@newagemicro.com> wrote:
>
> > I attempted to enable the kernel debugger on my Sequoia board, and I
> > get build errors:
> >   /linux-2.6.25-rc3/arch/powerpc/kernel/setup_32.c:254: undefined
> > reference to `set_debug_traps'
> >   /linux-2.6.25-rc3/arch/powerpc/kernel/setup_32.c:259: undefined
> > reference to `breakpoint'
> >
> > Josh: I assume you have used the kernel debugger with your 44x
> > boards, how did you build it?
>
>Why would you assume that?  I've never used kgdb on arch/powerpc
>kernels, nor have I ever tried to build it.
>
>I don't think kgdb is ported to powerpc at the moment.
>
>josh

I assumed that because I've always needed a debugger when 
implementing kernel level components. Since you've implemented kernel 
level support for several 44x processors, I just assumed that you 
needed kdbg at some point. So you're saying that your additions 
worked right out of the gate and you never needed a debugger?  You're my hero!
