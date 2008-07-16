Return-Path: <dgibson@ozlabs.org>
Date: Wed, 16 Jul 2008 15:44:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: DTC: libfdt Install Woes
Message-ID: <20080716054402.GB30636@yookeroo.seuss>
References: <1216149974.20700.14.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216149974.20700.14.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 02:26:14PM -0500, Jon Loeliger wrote:
> David,
> 
> Somewhat recently, the DTC commit 6a6c972cdf9e
> "dtc: Clean up included Makefile fragments"
> removed this line
> 
>     LIBFDT_INCLUDES = fdt.h libfdt.h
> 
> from the libfdt/Makefile.libfdt.  As a result,
> the standalone "make install" is onw failing.

Oops, that was a bit silly of me.

> 
> We could put that line back, or remove the
> top-level Makefile install target that is
> trying to use this definition.
> 
> I'm not sure which direction you want to head here.

I'd prefer to go with changing the top-level Makefile target.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
