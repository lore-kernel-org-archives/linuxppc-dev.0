Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Dec 2007 11:53:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 2/3] mpc82xx: Embedded Planet EP8248E support
Message-ID: <20071218005348.GC9489@localhost.localdomain>
References: <20071212225429.GB19027@loki.buserror.net>
	<20071217035912.GB3262@localhost.localdomain>
	<47669335.4050405@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47669335.4050405@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 17, 2007 at 09:18:13AM -0600, Scott Wood wrote:
> David Gibson wrote:
> > As I think I said about another tree, this mdio-under-bcsr arrangement
> > is pretty strange.  What's going on here.
> 
> As I answered then, it's just the way the hardware is.  I didn't design 
> it. :-P

I obviously missed when you answered this before, I was hoping for
some more detail.

I mean, obviously the MDIO bus is accessed via some of the
board-control registers.  What I'm questioning is whether it makes
sense to have a distinct node to represent the mdio bus, or whether
the phys should just hang straight of the bcsr node.

> >> +	soc@f0000000 {
> >> +		#address-cells = <1>;
> >> +		#size-cells = <1>;
> >> +		device_type = "soc";
> > 
> > Ditch the device_type.
> 
> No, it's used by the bootwrapper.  I'll get rid of it if you want to 
> write a find_node_by_compatible() function. :-)

Well, now that libfdt is merged, there is one :-p.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
