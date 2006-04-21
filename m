Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id A11A067A05
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Apr 2006 00:45:19 +1000 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Date: Fri, 21 Apr 2006 09:33:10 -0500
References: <20060420210201.GA25755@gate.ebshome.net>
	<20060420215514.GE25755@gate.ebshome.net>
	<1145594285.28014.12.camel@localhost.localdomain>
In-Reply-To: <1145594285.28014.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604210933.10888.bcook@bpointsys.com>
Cc: debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 20 April 2006 23:38, Benjamin Herrenschmidt wrote:
> On Thu, 2006-04-20 at 14:55 -0700, Eugene Surovegin wrote:
> > On Thu, Apr 20, 2006 at 11:10:55PM +0200, Gerhard Pircher wrote:
> > > Well, Freescale's PPC programming environment manual clearly states
> > > that this will not work on G4 CPUs (74xx). Also Benjamin Herrenschmidt
> > > told me, that this implementation will not work for the reasons I
> > > mentioned before. The approach I'm trying to implement was his idea, so
> > > I have to trust in him.
> >
> > Well, you aren't the first person who tries to run G4 with
> > CONFIG_NOT_COHERENT_CACHE. This was done before and I don't remember
> > that those people had to implement anything as complex as you are
> > trying to do.
> >
> > You can try asking on #mklinux. It always better to ask people who
> > actually _did_ this :).
> >
> > In fact, I just grepped 2.6 and found
> > #ifdef(CONFIG_NOT_COHERENT_CACHE) in syslib/mv64x60.c. Guess what
> > systems usually have this type of bridge? Not 4xx/8xx, that's for sure.
>
> I think some folks tried ... and failed.
>
> Ben.

I'm not claiming to understand all of the issues here, but I have some 
MV64460 / MPC7448-based systems, and they only boot if 
CONFIG_NOT_COHERENT_CACHE=y

 - Brent
