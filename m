Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 92052DDFD9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 03:22:56 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7RHMlGx030902
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 13:22:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7RHMkLY431582
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 11:22:46 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7RHMkvA019765
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 11:22:46 -0600
Date: Mon, 27 Aug 2007 12:22:45 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 3/3] [POWERPC] Add PCI support for AMCC 440EPx (sequoia)
Message-ID: <20070827122245.5ccc443b@weaponx.rchland.ibm.com>
In-Reply-To: <200708270821.35209.sr@denx.de>
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070825093001.4087.18160.stgit@localhost.localdomain>
	<20070827015719.GD12804@localhost.localdomain>
	<200708270821.35209.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 27 Aug 2007 08:21:35 +0200
Stefan Roese <sr@denx.de> wrote:

> > > +++ b/arch/powerpc/platforms/44x/ppc440epx-pci.c
> > > @@ -0,0 +1,192 @@
> > > +/*
> > > + * PPC44x PCI host support
> > > + *
> > > + * Vitaly Bordug <vitb@kernel.crashing.org>
> > > + * Stefan Roese <sr@denx.de>
> > > + *
> > > + * Based on arch/ppc sequoia pci bits, that are
> > > + * Copyright 2006-2007 DENX Software Engineering, Stefan Roese
> > > <sr@denx.de> + *
> > > + * Based on bamboo.c from Wade Farnsworth <wfarnsworth@mvista.com>
> > > + *      Copyright 2004 MontaVista Software Inc.
> > > + *      Copyright 2006 AMCC
> > > + * This program is free software; you can redistribute  it and/or modify
> > > it + * under  the terms of  the GNU General  Public License as published
> > > by the + * Free Software Foundation;  either version 2 of the  License,
> > > or (at your + * option) any later version.
> > > + */
> >
> > Unless there really is something peculiar about the EPx bridge
> > compared to say the GP, EP and other 4xx bridges, this should have a
> > more general name.
> 
> We originally started naming this file sequoia-pci.c and changed it to be 
> 440EPx specific (just by renaming). But you are right of course. We should 
> make it even more generic for 4xx PCI support. Perhaps we will overlook some 
> problems with other 4xx platforms, but those should be solved when other 
> platforms (Josh: 440ep and 405gp? ;)) will be added.
> 
> So what should it be called? arch/powerpc/syslib/ppc4xx_pci.c ?

That would work, yes.  I'd be happy to test out 440ep, 440gp, and 405gp
once the patches are reworked a bit per David and Segher's comments.

josh
