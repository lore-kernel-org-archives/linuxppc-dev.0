Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0996E2C029C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 21:27:14 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Craciun Diana Madalina-STFD002 <STFD002@freescale.com>
Subject: RE: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Tue, 19 Feb 2013 10:27:06 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D3A8B27@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-7-git-send-email-Varun.Sethi@freescale.com>
 <51234E27.9020604@freescale.com>
In-Reply-To: <51234E27.9020604@freescale.com>
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
> From: Craciun Diana Madalina-STFD002
> Sent: Tuesday, February 19, 2013 3:34 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
> linux-kernel@vger.kernel.org; Wood Scott-B07421; joro@8bytes.org; Yoder
> Stuart-B08248
> Subject: Re: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU
> API implementation.
>=20
> On 02/18/2013 02:52 PM, Varun Sethi wrote:
> > +
> > +#define PAACE_TCEF_FORMAT0_8B   0x00
> > +#define PAACE_TCEF_FORMAT1_RSVD 0x01
> > +
> > +#define PAACE_NUMBER_ENTRIES    0x1FF
>=20
> Where is this number coming from?
>=20
This is currently hard coded. We will not require these many entries once w=
e implement the LIODN allocation scheme.

-Varun
