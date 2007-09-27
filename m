Return-Path: <dgibson@ozlabs.org>
Date: Fri, 28 Sep 2007 00:17:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: dtc: Use libfdt/fdt.h instead of flat_dt.h
Message-ID: <20070927141721.GA13513@localhost.localdomain>
References: <20070926031105.GA26512@localhost.localdomain>
	<E1IatNe-0007Yv-Aw@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IatNe-0007Yv-Aw@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2007 at 08:26:14AM -0500, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > In the dtc tree, both flat_dt.h and libfdt/fdt.h have structures and
> > constants relating to the flattened device tree format derived from
> > asm-powerpc/prom.h in the kernel.  The former is used in dtc, the
> > latter in libfdt.
> > 
> > libfdt/fdt.h is the more recent, revised version, so use that
> > throughout, removing flat_dt.h.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Applied.
> 
> As instructed, I also ignored this patch:
>     dtc: Use a custom name for lexer output

Ta.

In not too long, I expect to have a series of patches getting libfdt
ready for use in the kernel.  A new patch with various makefile
cleanups including the lexer name patch will be part of that.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
