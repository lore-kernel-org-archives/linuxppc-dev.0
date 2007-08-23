Return-Path: <dgibson@ozlabs.org>
Date: Thu, 23 Aug 2007 13:33:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
Message-ID: <20070823033318.GJ7042@localhost.localdomain>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
	<2F7E4C06-9AC3-458A-B1E3-CA6E0BDD189A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2F7E4C06-9AC3-458A-B1E3-CA6E0BDD189A@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 10:33:55PM -0500, Kumar Gala wrote:
> 
> On Aug 22, 2007, at 10:19 AM, Kumar Gala wrote:
> 
> >Guys,
> >
> >I was wondering if I could get your help with looking at the
> >following lists and determining if we have an issue or not related
> >the following files:
> >
> >Getting some classification on these would be good.  Possibly
> >classifications, doesn't build in ARCH=powerpc, remove include, real
> >issue, etc.
> >
> >- k
> 
> My analysis of <asm/bootinfo.h> usage:
> 
> ./drivers/macintosh/adb-iop.c:#include <asm/bootinfo.h>	 remove
> ./drivers/char/vme_scc.c:#include <asm/bootinfo.h>		68k only
> ./drivers/char/serial167.c:#include <asm/bootinfo.h>		68k only
> ./drivers/serial/dz.c:#include <asm/bootinfo.h>		 decstation
> ./drivers/mtd/devices/ms02-nv.c:#include <asm/bootinfo.h>	decstation
> ./drivers/net/macsonic.c:#include <asm/bootinfo.h>		68k
> ./drivers/net/jazzsonic.c:#include <asm/bootinfo.h>		mips
> ./drivers/video/pmag-aa-fb.c:#include <asm/bootinfo.h>		mips
> ./drivers/video/maxinefb.c:#include <asm/bootinfo.h>		mips
> ./drivers/video/logo/logo.c:#include <asm/bootinfo.h>		mips
> ./drivers/video/macfb.c:#include <asm/bootinfo.h>		68k
> ./drivers/video/valkyriefb.c:#include <asm/bootinfo.h>		68k

Uh.. I'm pretty sure valkyriefb.c is for (old) PowerMacs, not 68k.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
