Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C80CC2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 00:48:09 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Sethi Varun-B16395 <B16395@freescale.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Yoder Stuart-B08248 <B08248@freescale.com>,
 Wood Scott-B07421 <B07421@freescale.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: RE: [PATCH 0/3 v2] iommu/fsl: PAMU driver fixes.
Date: Thu, 17 Oct 2013 13:47:38 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A5456C2@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381922582-28724-1-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1381922582-28724-1-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joerg,
Please consider these patches for 3.12.

Regards
Varun

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Wednesday, October 16, 2013 4:53 PM
> To: joro@8bytes.org; iommu@lists.linux-foundation.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Yoder Stuart-B08248;
> Wood Scott-B07421; alex.williamson@redhat.com; Bhushan Bharat-R65777
> Cc: Sethi Varun-B16395
> Subject: [PATCH 0/3 v2] iommu/fsl: PAMU driver fixes.
>=20
> The first patch fixes a build failure, when we try to build for a
> Freescale platform without PCI support.
>=20
> The second patch enables a default DMA window for the device, once it's
> detached from a domain. In case of vfio, once device is detached from a
> guest it can be again used by the host.
>=20
> The last patch adds the maintainer entry for the Freescale PAMU driver.
>=20
> Varun Sethi (3):
>   iommu/fsl: Factor out PCI specific code.
>   iommu/fsl: Enable default DMA window for PCIe devices once detached
>   Add maintainers entry for the Freescale PAMU driver.
>=20
>  MAINTAINERS                     |    7 ++
>  drivers/iommu/fsl_pamu.c        |   43 ++++++++++---
>  drivers/iommu/fsl_pamu.h        |    1 +
>  drivers/iommu/fsl_pamu_domain.c |  134 +++++++++++++++++++++++++--------
> ------
>  4 files changed, 128 insertions(+), 57 deletions(-)
>=20
> --
> 1.7.9.5
