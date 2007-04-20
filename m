Return-Path: <dgibson@ozlabs.org>
Date: Fri, 20 Apr 2007 10:08:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 9/10] Add device tree for Ebony
Message-ID: <20070420000858.GC13671@localhost.localdomain>
References: <20070418063626.D5DCCDDEBA@ozlabs.org>
	<1177006172.14328.13.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177006172.14328.13.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 19, 2007 at 01:09:32PM -0500, Jon Loeliger wrote:
> On Wed, 2007-04-18 at 01:36, David Gibson wrote:
> > Add a device tree for the Ebony evaluation board (440GP based).  This
> > tree is not complete or finalized.  This tree needs a very recent
> > version of dtc to process.
> 
> "recent" will get stale without absolute reference here.
> In fact,  -V 16 is "old" now even. :-)

Heh, yes..  Comment adjusted.

> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-03-21 13:23:48.000000000 +1100
> > @@ -0,0 +1,295 @@
> > +/*
> > + * Device Tree Source for IBM Ebony
> > + *
> > + * Copyright (c) 2006, 2007 IBM Corp.
> > + * Josh Boyer <jwboyer@linux.vnet.ibm.com>, David Gibson <dwg@au1.ibm.com>
> > + *
> > + * FIXME: Draft only!
> 
> Hrm.

Yes..?

> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without
> > + * any warranty of any kind, whether express or implied.
> > + *
> > + * To build:
> > + *   dtc -I dts -O asm -o ebony.S -b 0 -V 16 ebony.dts
> > + *   dtc -I dts -O dtb -o ebony.dtb -b 0 -V 16 ebony.dts
> 
> Really Version 16?  Can we just default to latest version
> by not specifying the -V arg at all?

Ah, yes, version reference removed.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
