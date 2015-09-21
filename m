Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0106.outbound.protection.outlook.com [157.56.111.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2EB981A0150
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 06:01:17 +1000 (AEST)
Message-ID: <1442865662.19102.172.camel@freescale.com>
Subject: Re: [PATCH 2/4] powerpc/device-tree: bindings for DSP
 cores/clusters for Freescale SOCs
From: Scott Wood <scottwood@freescale.com>
To: Aggrwal Poonam-B10812 <Poonam.Aggrwal@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
Date: Mon, 21 Sep 2015 15:01:02 -0500
In-Reply-To: <DM2PR0301MB07016FC9BFCEB4A2C38168AB8C460@DM2PR0301MB0701.namprd03.prod.outlook.com>
References: <1442686567-14320-1-git-send-email-poonam.aggrwal@freescale.com>
 <1442708128.19102.147.camel@freescale.com>
 <DM2PR0301MB07016FC9BFCEB4A2C38168AB8C460@DM2PR0301MB0701.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-21 at 03:36 -0500, Aggrwal Poonam-B10812 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Sunday, September 20, 2015 5:45 AM
> > To: Aggrwal Poonam-B10812 <Poonam.Aggrwal@freescale.com>
> > Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; 
> > devicetree-
> > discuss@lists.ozlabs.org
> > Subject: Re: [PATCH 2/4] powerpc/device-tree: bindings for DSP
> > cores/clusters for Freescale SOCs
> > 
> > On Sat, 2015-09-19 at 23:46 +0530, Poonam Aggrwal wrote:
> > > From: poonam aggrwal <poonam.aggrwal@freescale.com>
> > > 
> > > Device Tree Bindings for DSP CPU clusters and DSP CPUs for Freescale
> > > PowerPC SOCs which have DSP CPUs in addition to PowerPC CPUs.
> > > For example B4860 has 3 DSP clusters which have 2 SC3900 cores each.
> > > 
> > > Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> > > ---
> > > - based of: 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >   branch master
> > > 
> > > This patch was sent earlier and some comments were received. Some have
> > > been taken care; others we can further discuss.  Apologize for not
> > > following up on them in time.
> > >  .../devicetree/bindings/powerpc/fsl/dsp-cpus.txt   | 78
> > > ++++++++++++++++++++++
> > >  1 file changed, 78 insertions(+)
> > >  create mode 100644
> > Documentation/devicetree/bindings/powerpc/fsl/dsp-
> > > cpus.txt
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt
> > > b/Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt
> > > new file mode 100644
> > > index 0000000..6d901ef
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/powerpc/fsl/dsp-cpus.txt
> > > @@ -0,0 +1,78 @@
> > > 
> > +=========================================================
> > ==========
> > > +Binding for DSP CPU clusters and DSP CPUs for Freescale SOCs which
> > > +have DSP CPUs in addition to PowerPC cpus.
> > > +Copyright 2013 Freescale Semiconductor Inc.
> > > +
> > > +Power Architecture CPUs in Freescale SOCs are represented in device
> > > +trees
> > > as
> > > +per the definition in ePAPR.
> > > +
> > > +Required properties for DSP CPU cluster:
> > > +- compatible : should be "fsl,sc3900-cluster".
> > > +- reg : should contain the cluster index
> > > +
> > > +Required properties for DSP CPU:
> > > +- compatible : should be "fsl,sc3900".
> > > +- reg : should contain index of DSP CPU within the DSP clsuter.
> > > +- next-level-cache : should point to the phandle of the next-level L2
> > > cache.
> > 
> > Why is the dsp-clusters container only shown in the example, not the 
> > binding
> > itself?
> 
> I will try to add more description in the binding for cluster; And the 
> structure of dsp cluster (like sub node of DSP cluster is core, etc).
> Did I get your feedback right?

No, I was complaining that the example has a "dsp-clusters" container node 
and the binding itself doesn't mention it at all.

-Scott
