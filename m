Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id A985F67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 10:15:42 +1100 (EST)
Date: Wed, 2 Mar 2005 16:15:30 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050302161530.D31614@cox.net>
References: <20050302105201.C31614@cox.net>
	<b83e8f546345414634e6c7518b441996@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b83e8f546345414634e6c7518b441996@freescale.com>;
	from kumar.gala@freescale.com on Wed, Mar 02, 2005 at 05:06:31PM
	-0600
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: PowerPC4xx Watchdog
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Mar 02, 2005 at 05:06:31PM -0600, Kumar Gala wrote:
> Matt,
> 
> [snip]
> 
> > What do you see as the advantage to having a watchdog driver
> >  that uses the booke hardware watchdog facility over a generic
> >  timebase driven driver?
> 
> I would think the watchdog would be useful in cases that the normal 
> decrementer exceptions gets disabled when MSR[EE] = 0.

That's the only thing I can think of.  I guess my question then
is whether people think this is important enough in practice
to have the hardware watchdog as an alternative. My guess is yes,
but I don't have a strong opinion. 

-Matt
