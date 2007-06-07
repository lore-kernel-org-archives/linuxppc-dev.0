Return-Path: <dgibson@ozlabs.org>
Date: Fri, 8 Jun 2007 09:34:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Fix drivers/rtc/Kconfig for powerpc
Message-ID: <20070607233431.GA17298@localhost.localdomain>
References: <1181149064.5674.134.camel@rhino>
	<1181149622.12740.32.camel@ld0161-tx32>
	<1181150240.5674.139.camel@rhino>
	<1181232488.31686.19.camel@ld0161-tx32>
	<1181233980.5674.174.camel@rhino>
	<1181234266.31686.37.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1181234266.31686.37.camel@ld0161-tx32>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 07, 2007 at 11:37:46AM -0500, Jon Loeliger wrote:
> On Thu, 2007-06-07 at 11:33, Wade Farnsworth wrote:
> > 
> > But since this is in drivers/rtc/Kconfig, wouldn't the maintainer of
> > that subsystem be expected to pick this up?
> 
> Oh, sure.  In which case he/she may be waiting on
> someone over in PowerPC land to ACK it first. :-)
> Dunno.

Sure.  This patch is so simple though, I think it could go straight to
Andrew Morton.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
