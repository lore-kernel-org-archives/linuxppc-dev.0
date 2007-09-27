Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Use libfdt/fdt.h instead of flat_dt.h 
In-Reply-To: Your message of "Wed, 26 Sep 2007 13:11:05 +1000."
	<20070926031105.GA26512@localhost.localdomain>
References: <20070926031105.GA26512@localhost.localdomain> 
Date: Thu, 27 Sep 2007 08:26:14 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IatNe-0007Yv-Aw@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> In the dtc tree, both flat_dt.h and libfdt/fdt.h have structures and
> constants relating to the flattened device tree format derived from
> asm-powerpc/prom.h in the kernel.  The former is used in dtc, the
> latter in libfdt.
> 
> libfdt/fdt.h is the more recent, revised version, so use that
> throughout, removing flat_dt.h.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

As instructed, I also ignored this patch:
    dtc: Use a custom name for lexer output

Thanks,
jdl
