Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0101.outbound.protection.outlook.com [157.56.111.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05B581A0BD4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 05:33:24 +1100 (AEDT)
Message-ID: <1417804386.334.13.camel@freescale.com>
Subject: Re: [RESEND PATCH v4] dmaengine: Driver support for FSL RaidEngine
 device.
From: Scott Wood <scottwood@freescale.com>
To: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 5 Dec 2014 12:33:06 -0600
In-Reply-To: <20141205162823.GN3411@intel.com>
References: <1413530900-22732-1-git-send-email-xuelin.shi@freescale.com>
 <20141205162823.GN3411@intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Harninder Rai <harninder.rai@freescale.com>,
 Naveen Burmi <naveenburmi@freescale.com>, dmaengine@vger.kernel.org,
 xuelin.shi@freescale.com, linuxppc-dev@lists.ozlabs.org,
 dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-12-05 at 21:58 +0530, Vinod Koul wrote:
> On Fri, Oct 17, 2014 at 03:28:20PM +0800, xuelin.shi@freescale.com wrote:
> > +/*
> > + * drivers/dma/fsl_raid.c
> > + *
> > + * Freescale RAID Engine device driver
> > + *
> > + * Author:
> > + *	Harninder Rai <harninder.rai@freescale.com>
> > + *	Naveen Burmi <naveenburmi@freescale.com>
> > + *
> > + * Rewrite:
> > + *	Xuelin Shi <xuelin.shi@freescale.com>
> > + *
> > + * Copyright (c) 2010-2014 Freescale Semiconductor, Inc.
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions are met:
> > + *     * Redistributions of source code must retain the above copyright
> > + *       notice, this list of conditions and the following disclaimer.
> > + *     * Redistributions in binary form must reproduce the above copyright
> > + *       notice, this list of conditions and the following disclaimer in the
> > + *       documentation and/or other materials provided with the distribution.
> > + *     * Neither the name of Freescale Semiconductor nor the
> > + *       names of its contributors may be used to endorse or promote products
> > + *       derived from this software without specific prior written permission.
> hmmm, this doesnt sound right. BSD header in kernel code
> I am not a lawyer but for kernel this doesn't sound right. 

There's plenty of dual-licensed code in the kernel (try greping for
"Dual BSD" or "in source and binary").  It's fine if the code isn't
derived from other code which is GPL-only or otherwise incompatibly
licensed.  Even if portions are considered derivative it ought to be
possible to specify expanded permissions on the portions which aren't
derivative.

This isn't even the first dual-licensed dmaengine driver; see
drivers/dma/ioat/dma_v3.c.  There's also drivers/dma/ioat/pci.c which
claims MODULE_LICENSE("Dual BSD/GPL") but has a GPL-only comment header.

> Why cant this be only GPL? Why does this deviate from norm?

Why must it be only GPL?  Insisting on that is not the norm in Linux. 
Here are Linus's comments on the matter:

http://yarchive.net/comp/linux/dual_license_bsd_gpl.html

-Scott
