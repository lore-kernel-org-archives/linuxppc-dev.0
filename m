Return-Path: <dgibson@ozlabs.org>
Date: Mon, 30 Apr 2007 13:40:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Small cleanups to the cuboot bootwrapper code
Message-ID: <20070430034033.GA6436@localhost.localdomain>
References: <20070427020154.GA20608@localhost.localdomain>
	<463237EA.4010102@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <463237EA.4010102@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 27, 2007 at 12:50:34PM -0500, Scott Wood wrote:
> David Gibson wrote:
> > Index: working-2.6/arch/powerpc/boot/Makefile
> > ===================================================================
> > --- working-2.6.orig/arch/powerpc/boot/Makefile	2007-04-27 11:48:56.000000000 +1000
> > +++ working-2.6/arch/powerpc/boot/Makefile	2007-04-27 11:57:41.000000000 +1000
> > @@ -129,7 +129,8 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.ps
> >  image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
> >  image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
> >  image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
> > -image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage cuImage
> > +image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
> > +image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
> 
> You need to update BOOT_TARGETS in arch/powerpc/Makefile as well.
> Otherwise, it looks good.

Ok, revised patch coming shortly.  Actually, I just removed cuImage
from the BOOT_TARGETS list.  Since the only sensible thing it could
really be is another alias for zImage, I don't see that there was
really much point to it.  Patch also updated to apply on top of your
85xx additions.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
