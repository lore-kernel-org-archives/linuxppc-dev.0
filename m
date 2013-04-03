Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DEB342C0117
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 16:17:17 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 2/5 v11] powerpc: Add iommu domain pointer to device
 archdata
Date: Wed, 3 Apr 2013 05:17:07 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D450439@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
 <1364500442-20927-3-git-send-email-Varun.Sethi@freescale.com>
 <20130402150842.GG15687@8bytes.org>
In-Reply-To: <20130402150842.GG15687@8bytes.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
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

Kumar/Ben,
Any comments?

(Had checked with Ben (on IRC) sometime back, he was fine with this patch)

Regards
Varun


> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Tuesday, April 02, 2013 8:39 PM
> To: Sethi Varun-B16395
> Cc: Yoder Stuart-B08248; Wood Scott-B07421; iommu@lists.linux-
> foundation.org; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; galak@kernel.crashing.org;
> benh@kernel.crashing.org
> Subject: Re: [PATCH 2/5 v11] powerpc: Add iommu domain pointer to device
> archdata
>=20
> On Fri, Mar 29, 2013 at 01:23:59AM +0530, Varun Sethi wrote:
> > Add an iommu domain pointer to device (powerpc) archdata.  Devices are
> > attached to iommu domains and this pointer provides a mechanism to
> > correlate between a device and the associated iommu domain.  This
> > field is set when a device is attached to a domain.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
>=20
> This patch needs to be Acked by the PPC maintainers.
>=20
>=20
