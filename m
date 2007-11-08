Return-Path: <dgibson@ozlabs.org>
Date: Fri, 9 Nov 2007 09:30:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: mpc8xxx MDS board RTC fixes
Message-ID: <20071108223003.GA18592@localhost.localdomain>
References: <20071108133706.961af8d2.kim.phillips@freescale.com>
	<F67D40A1-D8C9-4F96-A526-E848FDFDEA0B@kernel.crashing.org>
	<47336CE7.5070807@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47336CE7.5070807@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 08, 2007 at 02:09:11PM -0600, Scott Wood wrote:
> Kumar Gala wrote:
> > should the mpc8568mds.dts be updated?
> 
> It already has been.
> 
> > Also, what code is parsing the device tree for the rtc node?
> 
> There's code in fsl_soc.c (which should be made more generic).

Indeed.  I guess we're going to want a library function which any
device tree aware i2c-bridge driver can use to instantiate the right
i2c-layer data structures for all the bridge's subnodes.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
