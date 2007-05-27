Return-Path: <dgibson@ozlabs.org>
Date: Mon, 28 May 2007 09:20:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Rob Landley <rob@landley.net>
Subject: Re: Porting "prep" from ppc to powerpc.
Message-ID: <20070527232055.GA23768@localhost.localdomain>
References: <200705252238.39819.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200705252238.39819.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 25, 2007 at 10:38:39PM -0400, Rob Landley wrote:
> Is anyone already doing this?  I asked around here a few weeks ago and got the 
> advice:
> 
> > In theory.. copy the files from ppc/platforms/prep.* to
> > powerpc/platforms/prep/ 
> > and make some Kconfigs and see what breaks :)

Actually, I don't really recommend that method in any case.

Instead I suggest making a Kconfig under arch/powerpc, then adding
things until it builds, then adding things until it boots.  When you
need to know what has to be done at a particular point, consult
arch/ppc.

> Unfortunately, there isn't a ppc/platforms/prep.  Under arch/ppc there's:
> 
> ./boot/simple/misc-prep.c
> ./boot/simple/prepmap.c
> ./boot/utils/mkprep.c
> ./configs/prep_defconfig
> ./platforms/prep_pci.c
> ./platforms/prep_setup.c
> ./syslib/prep_nvram.c
> 
> And I'm not sure which are relevant.  Any hints?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
