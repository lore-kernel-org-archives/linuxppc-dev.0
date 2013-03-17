Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16C0F2C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 02:49:28 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
 implementation.
Date: Sun, 17 Mar 2013 15:49:20 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D40ABC2@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1363200580-11623-1-git-send-email-Varun.Sethi@freescale.com>
 <0080B56D-8417-41B9-8341-665457D04DE6@kernel.crashing.org>
 <DF9A711B-63AF-411C-84E4-0C9F61A2EB21@kernel.crashing.org>
In-Reply-To: <DF9A711B-63AF-411C-84E4-0C9F61A2EB21@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>,
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
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, March 15, 2013 1:53 AM
> To: Sethi Varun-B16395
> Cc: joro@8bytes.org; linux-kernel@vger.kernel.org; Yoder Stuart-B08248;
> iommu@lists.linux-foundation.org; Wood Scott-B07421; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
>=20
>=20
> On Mar 14, 2013, at 3:20 PM, Kumar Gala wrote:
>=20
> >
> > On Mar 13, 2013, at 1:49 PM, Varun Sethi wrote:
> >
> >> +/*
> >> + * Table of SVRs and the corresponding PORT_ID values.
> >> + *
> >> + * All future CoreNet-enabled SOCs will have this erratum fixed, so
> >> +this table
> >> + * should never need to be updated.  SVRs are guaranteed to be
> >> +unique, so
> >> + * there is no worry that a future SOC will inadvertently have one
> >> +of these
> >> + * values.
> >> + */
> >
> > Maybe add to the comment about what port_id represents
>=20
> also, add reference to the erratum #/id/name
>=20
[Sethi Varun-B16395] Ok.

-Varun
