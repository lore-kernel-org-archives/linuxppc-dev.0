Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA4402C013F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 02:49:56 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Yoder Stuart-B08248 <B08248@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
Date: Sun, 17 Mar 2013 15:49:47 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D40ABD3@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1363200580-11623-1-git-send-email-Varun.Sethi@freescale.com>
 <0080B56D-8417-41B9-8341-665457D04DE6@kernel.crashing.org>
 <9F6FE96B71CF29479FF1CDC8046E1503586936@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E1503586936@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Yoder Stuart-B08248
> Sent: Friday, March 15, 2013 2:45 AM
> To: Kumar Gala; Sethi Varun-B16395
> Cc: joro@8bytes.org; iommu@lists.linux-foundation.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org;
> benh@kernel.crashing.org; Wood Scott-B07421
> Subject: RE: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
>=20
>=20
>=20
> > -----Original Message-----
> > From: Kumar Gala [mailto:galak@kernel.crashing.org]
> > Sent: Thursday, March 14, 2013 3:20 PM
> > To: Sethi Varun-B16395
> > Cc: joro@8bytes.org; iommu@lists.linux-foundation.org;
> > linuxppc-dev@lists.ozlabs.org; linux- kernel@vger.kernel.org;
> > benh@kernel.crashing.org; Wood Scott-B07421; Yoder Stuart-B08248
> > Subject: Re: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
> >
> >
> > On Mar 13, 2013, at 1:49 PM, Varun Sethi wrote:
> >
> > > +/*
> > > + * Table of SVRs and the corresponding PORT_ID values.
> > > + *
> > > + * All future CoreNet-enabled SOCs will have this erratum fixed, so
> > > +this table
> > > + * should never need to be updated.  SVRs are guaranteed to be
> > > +unique, so
> > > + * there is no worry that a future SOC will inadvertently have one
> > > +of these
> > > + * values.
> > > + */
> >
> > Maybe add to the comment about what port_id represents
>=20
> When you update the comment, I would also suggest identifying the
> specific errata here (A-004510) so that it's easy to reference back to
> the specific issue this code is fixing.

[Sethi Varun-B16395] Ok

-Varun
