Return-Path: <boris.brezillon@free-electrons.com>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rGdKV1wDwzDqcZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 May 2016 06:44:13 +1000 (AEST)
Date: Fri, 27 May 2016 22:44:01 +0200
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Leo Li <pku.leo@gmail.com>, Brian Norris <computersforpeace@gmail.com>
Cc: Yang-Leo Li <leoyang.li@nxp.com>, Prabhakar Kushwaha
 <prabhakar.kushwaha@nxp.com>, Scott Wood <oss@buserror.net>, Raghav Dogra
 <raghav.dogra@nxp.com>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Raghav Dogra <raghav@freescale.com>,
 Jaiprakash Singh <b44839@freescale.com>
Subject: Re: [PATCH][v3] mtd/ifc: Add support for IFC controller version 2.0
Message-ID: <20160527224401.4b776ad4@bbrezillon>
In-Reply-To: <CADRPPNSeQsOZZ9XRR4BOfZvewoB9RoEy0KzPrRzoDm21LtacnQ@mail.gmail.com>
References: <1455708258-3831-1-git-send-email-raghav.dogra@nxp.com>
 <CADRPPNS1i1XgtpyiT_=rDuDXBDn=ehNY32=RKTC9hdKXhWWq8A@mail.gmail.com>
 <1455840434.2463.97.camel@buserror.net>
 <CADRPPNTauz=T9oWCeZy8G8s0vo9fmieRhn=Gd3jVqqJJEHV_ag@mail.gmail.com>
 <20160406175254.GC5243@localhost>
 <AM2PR04MB0770036256E58407BD045C5A8F9F0@AM2PR04MB0770.eurprd04.prod.outlook.com>
 <20160408024507.69fb4fc1@bbrezillon>
 <CADRPPNRXj_00GF-h_5yHtKPMU=U1C8PXQLZqEVzQvJZobmM7dg@mail.gmail.com>
 <20160525223412.086e45e9@bbrezillon>
 <CADRPPNSeQsOZZ9XRR4BOfZvewoB9RoEy0KzPrRzoDm21LtacnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Leo,

On Fri, 27 May 2016 15:15:00 -0500
Leo Li <pku.leo@gmail.com> wrote:

> On Wed, May 25, 2016 at 3:34 PM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > On Wed, 25 May 2016 14:18:43 -0500
> > Leo Li <pku.leo@gmail.com> wrote:
> >  
> >> On Thu, Apr 7, 2016 at 7:45 PM, Boris Brezillon
> >> <boris.brezillon@free-electrons.com> wrote:  
> >> > On Wed, 6 Apr 2016 18:53:39 +0000
> >> > Yang-Leo Li <leoyang.li@nxp.com> wrote:
> >> >  
> >> >>
> >> >>  
> >> >> > -----Original Message-----
> >> >> > From: Brian Norris [mailto:computersforpeace@gmail.com]
> >> >> > Sent: Wednesday, April 06, 2016 12:53 PM
> >> >> > To: Li Yang <leoli@freescale.com>
> >> >> > Cc: Scott Wood <oss@buserror.net>; Raghav Dogra <raghav.dogra@nxp.com>;
> >> >> > linux-mtd@lists.infradead.org; linuxppc-dev <linuxppc-dev@lists.ozlabs.org>;
> >> >> > Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Raghav Dogra
> >> >> > <raghav@freescale.com>; Jaiprakash Singh <b44839@freescale.com>; Boris
> >> >> > Brezillon <boris.brezillon@free-electrons.com>
> >> >> > Subject: Re: [PATCH][v3] mtd/ifc: Add support for IFC controller version 2.0
> >> >> >
> >> >> > Hi,
> >> >> >
> >> >> > On Wed, Mar 30, 2016 at 03:43:40PM -0500, Li Yang wrote:  
> >> >> > > Hi Brian,
> >> >> > >
> >> >> > > Could you help to review and pull in this patch and the Kconfig update
> >> >> > > after this patch(https://patchwork.ozlabs.org/patch/557389/)?  It  
> >> >> >
> >> >> > It's probably best for Boris to apply this now.  
> >> >>
> >> >> Thanks Brian.  I see Boris is taking over the maintenance of NAND recently, we will follow up with him.
> >> >>
> >> >> Hi Boris,
> >> >>
> >> >> Can you consider to pull in this patch and then Kconfig patch (https://patchwork.ozlabs.org/patch/557389/)?  
> >> >
> >> > Applied.
> >> >
> >> > Thanks,
> >> >
> >> > Boris  
> >>
> >> Hi Boris,
> >>
> >> It seems that the patch at https://patchwork.ozlabs.org/patch/557389/
> >> mentioned above was not in tree for 4.7.  Can you review and apply
> >> that patch too?  
> >
> > I see it in the PR Brian sent 2 days ago [1], so it should appear in
> > Linus tree soon.
> >
> > Regards,
> >
> > Boris
> >
> > [1]https://lkml.org/lkml/2016/5/24/9  
> 
> 
> The pull request does have patch "mtd/ifc: Add support for IFC
> controller version 2.0", but it doesn't have another patch
> "driver/memory: Update dependency of IFC for
> Layerscape"(https://patchwork.ozlabs.org/patch/557389/) needed to make
> the driver selectable on new hardware.

Sorry, I overlooked that part in your different emails (even though you
clearly stated that you needed both patches).

For my defense, I haven't followed the patch series from the beginning,
and only took the patch because Brian suggested to do so (and the
changes seemed ok).
It would have been clearer if the different patches were part of the
same series.

Anyway, Brian, can you take it into your tree and make it appear in
-rc1 (or earlier if it's still possible)?

BTW, in the patch description you say you're only modifying a Kconfig
dependency, but you're actually doing more than that: you're removing
an asm header inclusion and manually include several other headers
(which I guess were previously included by asm/prom.h).

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
