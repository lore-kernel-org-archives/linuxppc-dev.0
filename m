Return-Path: <B16395@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB17D2C04F7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 23:02:46 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 1/3 v2] iommu: Move swap_pci_ref function to pci.h.
Date: Tue, 23 Apr 2013 13:02:38 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D4B4A00@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1366691726-9023-1-git-send-email-Varun.Sethi@freescale.com>
 <20130423125827.GD2589@8bytes.org>
In-Reply-To: <20130423125827.GD2589@8bytes.org>
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

Thanks.

> -----Original Message-----
> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Joerg Roedel
> Sent: Tuesday, April 23, 2013 6:32 PM
> To: Sethi Varun-B16395
> Cc: galak@kernel.crashing.org; benh@kernel.crashing.org; Yoder Stuart-
> B08248; linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 1/3 v2] iommu: Move swap_pci_ref function to pci.h.
>=20
> On Tue, Apr 23, 2013 at 10:05:24AM +0530, Varun Sethi wrote:
> > +#ifndef __PCI_H
> > +#define __PCI_H
>=20
> Using __PCI_H is not a wise choice, it has certainly a high risk of a
> collision. Anyway, I changed it to __IOMMU_PCI_H and applied the patch.
>=20
>=20
> 	Joerg
>=20
>=20
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
