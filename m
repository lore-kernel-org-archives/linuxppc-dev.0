Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8BF22C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2012 12:47:06 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: RE: [PATCH 0/4] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Fri, 21 Dec 2012 01:46:56 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D2DFA6A@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1355493114-21776-1-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1355493114-21776-1-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "joerg.roedel@amd.com" <joerg.roedel@amd.com>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Sethi Varun-B16395 <B16395@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ping!!

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Friday, December 14, 2012 7:22 PM
> To: joerg.roedel@amd.com; iommu@lists.linux-foundation.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Tabi Timur-B04825;
> Wood Scott-B07421
> Cc: Sethi Varun-B16395
> Subject: [PATCH 0/4] iommu/fsl: Freescale PAMU driver and IOMMU API
> implementation.
>=20
> This patchset provides the Freescale PAMU (Peripheral Access Management
> Unit) driver and the corresponding IOMMU API implementation. PAMU is the
> IOMMU present on Freescale QorIQ platforms. PAMU can authorize memory
> access, remap the memory address, and remap the I/O transaction type.
>=20
> This set consists of the following patches:
> 1. Addition of new field in the device (powerpc) archdata structure for
> storing iommu domain information
>    pointer. This pointer is stored when the device is attached to a
> particular iommu domain.
> 2. Add PAMU bypass enable register to the ccsr_guts structure.
> 3. Addition of domain attributes required by the PAMU driver IOMMU API.
> 4. PAMU driver and IOMMU API implementation.
>=20
> This patch set is based on the next branch of the iommu git tree
> maintained by Joerg.
>=20
> Varun Sethi (4):
>   store iommu domain info in device arch data.
>   add pamu bypass enable register to guts.
>   Add iommu attributes for PAMU
>   FSL PAMU driver.
>=20
>  arch/powerpc/include/asm/device.h   |    4 +
>  arch/powerpc/include/asm/fsl_guts.h |    4 +-
>  drivers/iommu/Kconfig               |    8 +
>  drivers/iommu/Makefile              |    1 +
>  drivers/iommu/fsl_pamu.c            | 1152
> +++++++++++++++++++++++++++++++++++
>  drivers/iommu/fsl_pamu.h            |  398 ++++++++++++
>  drivers/iommu/fsl_pamu_domain.c     | 1033
> +++++++++++++++++++++++++++++++
>  drivers/iommu/fsl_pamu_domain.h     |   96 +++
>  include/linux/iommu.h               |   49 ++
>  9 files changed, 2744 insertions(+), 1 deletions(-)  create mode 100644
> drivers/iommu/fsl_pamu.c  create mode 100644 drivers/iommu/fsl_pamu.h
> create mode 100644 drivers/iommu/fsl_pamu_domain.c  create mode 100644
> drivers/iommu/fsl_pamu_domain.h
>=20
> --
> 1.7.4.1
