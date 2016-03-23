Return-Path: <madalin.bucur@nxp.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0089.outbound.protection.outlook.com [157.56.112.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVSB0091WzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 22:33:27 +1100 (AEDT)
From: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
To: "joro@8bytes.org" <joro@8bytes.org>, Andy Fleming <afleming@gmail.com>
CC: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [v2] powerpc: Fix incorrect PPC32 PAMU dependency
Date: Wed, 23 Mar 2016 09:59:08 +0000
Message-ID: <AM4PR04MB16047A161F9CFDF7C65FCCC1EC810@AM4PR04MB1604.eurprd04.prod.outlook.com>
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

> -----Original Message-----
> From: Andy Fleming <afleming@gmail.com>
> To: joro@8bytes.org
> Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
> Subject: [v2] powerpc: Fix incorrect PPC32 PAMU dependency
>
> The Freescale PAMU can be enabled on both 32 and 64-bit Power
> chips. Commit 477ab7a19cec8409e4e2dd10e7348e4cac3c06e5
> (iommu: Make more drivers depend on COMPILE_TEST)
> restricted PAMU to PPC32. PPC covers both.
>
> Signed-off-by: Andy Fleming <afleming@gmail.com>

Tested-by: Madalin Bucur <madalin.bucur@freescale.com>
