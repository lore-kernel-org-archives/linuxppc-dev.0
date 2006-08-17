Return-Path: <mgreer@mvista.com>
Date: Thu, 17 Aug 2006 14:13:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 6/6] bootwrapper: Add support for the sandpoint platform
Message-ID: <20060817211353.GA1402@mag.az.mvista.com>
References: <20060719231725.GG3887@mag.az.mvista.com>
	<Pine.LNX.4.60.0608172200080.8228@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0608172200080.8228@poirot.grange>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 17, 2006 at 10:16:16PM +0200, Guennadi Liakhovetski wrote:
> On Wed, 19 Jul 2006, Mark A. Greer wrote:
> 
> > This patch adds support for the Freescale Sandpoint platform
> > to the bootwrapper.

Hi Guennadi.

> Mark,
> 
> you put sandpoint.c and mpc10x.c under boot... I don't quite understand 
> your concept now: you mean this is the code needed to __boot__ sandpoint. 

Depends on what you mean by "__boot__".  This is the code needed to
prepare things--the flat dev tree in this case--so that the kernel
can boot when running the DINK firmware on a sandpoint.

> Ok. I can also imagine that as soon as the system is up you don't need any 
> further specific code - only .init* sections. But - does this mean that 
> every platform will now put its support flat under boot?

You need to read <file:Documentation/powerpc/booting-without-of.txt>.

> Or is it a 
> special case? Or are there also run-time fixups that you didn't include 
> with this patch-series?  Also <board>_reset doesn't quite fit under boot,

Yes it does.  Follow exit().

> or am I misunderstanding something?

Yes, you're missing the whole point of the patch series...

Did you read "[PATCH 0/6] bootwrapper: arch/powerpc/boot code reorg
patches"?

The intent was not to add kernel support for the sanpoint.  The intent
was to solicit comments on a reorg of the bootwrapper code.

Mark
