Return-Path: <dgibson@ozlabs.org>
Date: Thu, 3 May 2007 22:22:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: powerpc_flash_init(), wtf!?
Message-ID: <20070503122213.GD26659@localhost.localdomain>
References: <20070501051804.GB3881@localhost.localdomain>
	<20070503103534.63ff67b6@localhost.localdomain>
	<20070503070358.GA9430@localhost.localdomain>
	<4639CF44.6020608@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4639CF44.6020608@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 04:02:12PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> David Gibson wrote:
> 
> >>>Unless someone who actually knows how this code was intended to be
> >>>used can suggest a more polite way of fixing it.
> 
> >>I guess, the idea was for this stuff to be updated once one of the
> >>dts inside boot/ would have physmap nodes added. I have
> >>rom/physmap[dts] rehaul in my TODO list, but it has (so far at
> >>least) little chance to happen during this merge window. Yet, if
> >>someone has suggestions and/or some interest for this to be cured,
> >>it will gain priority. Otherwise, I'll replace actual erroneous code
> >>with kind of rant that it's up to BSP code to take care of
> >>of_devices to be registered, using of_platform_bus_probe() or other
> >>way.
> 
> > I'm having some trouble parsing that paragraph.  At this stage I don't
> > see any reason to hold off on tearing out arch/powerpc/sysdev/rom.c,
> > any necessary changes to replace it will go in the platform code or
> 
>     It doesn't seem a flexible enough approach. We could continue using 
> platform devices then.

Sorry, I don't follow you.

> > other places.
> 
>     Any ideas where else?

Not really.  I don't immediately see a case where doing it from the
platform code wouldn't be right.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
