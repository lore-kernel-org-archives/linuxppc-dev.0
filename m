Return-Path: <codrin.ciubotariu@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0093.outbound.protection.outlook.com [157.55.234.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTwBp67pPzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 01:32:17 +1100 (AEDT)
From: Codrin Constantin Ciubotariu <codrin.ciubotariu@nxp.com>
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC: "scottwood@freescale.com" <scottwood@freescale.com>,
 "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 0/7] PAMU driver update
Date: Tue, 22 Mar 2016 13:59:56 +0000
Message-ID: <VI1PR0401MB1792938B9AA394D7E3F2A1D7E9800@VI1PR0401MB1792.eurprd04.prod.outlook.com>
References: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
In-Reply-To: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
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

Hi,

Anyone has any comments on this patch-set? Please share your thoughts.

Thanks and best regards,
Codrin

> -----Original Message-----
> From: Codrin Ciubotariu [mailto:codrin.ciubotariu@nxp.com]
> Sent: Monday, 07 March, 2016 5:34 PM
> To: iommu@lists.linux-foundation.org
> Cc: scottwood@freescale.com; Varun.Sethi@freescale.com; linuxppc-
> dev@lists.ozlabs.org; Codrin Constantin Ciubotariu
> Subject: [PATCH 0/7] PAMU driver update
>=20
> This patchset addresses a few issues found on PAMU IOMMU and small change=
s to
> enable power management and to support the
> L3 cache controller on some newer boards.
>=20
> The series starts with a clean-up patch, followed by two errata fixes: A-=
007907
> and A-005982. It continues with two fixes for PCIe support. The last two =
patches
> add support for power management and compatible strings for new L3 contro=
ller
> device-tree nodes.
>=20
> Codrin Ciubotariu (2):
>   iommu/fsl: Fix most checkpatch warnings and typos
>   iommu/fsl: Work around erratum A-007907
>=20
> Varun Sethi (5):
>   iommu/fsl: Enable OMT cache, before invalidating PAACT and SPAACT
>     cache
>   iommu/fsl: Factor out PCI specific code
>   iommu/fsl: Enable default DMA window for PCIe devices once detached
>     from domain
>   iommu/fsl: PAMU power management support
>   iommu/fsl: Added cache controller compatible strings for SOCs
>=20
>  drivers/iommu/fsl_pamu.c        | 322 ++++++++++++++++++++++++++++++++--=
------
>  drivers/iommu/fsl_pamu.h        |  30 ++--
>  drivers/iommu/fsl_pamu_domain.c | 160 +++++++++++++-------
>  drivers/iommu/fsl_pamu_domain.h |   2 +-
>  4 files changed, 381 insertions(+), 133 deletions(-)
>=20
> --
> 1.9.3
