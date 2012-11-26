Return-Path: <B16395@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0762F2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 16:33:44 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 1/4 v2] iommu/fsl: Store iommu domain information
 pointer in archdata.
Date: Mon, 26 Nov 2012 05:33:34 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D29AE62@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1353419697-31269-1-git-send-email-Varun.Sethi@freescale.com>
 <1353419697-31269-2-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1353419697-31269-2-git-send-email-Varun.Sethi@freescale.com>
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

Hi Kumar,
Can you please apply this patch.

Regards
Varun

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Tuesday, November 20, 2012 7:25 PM
> To: joerg.roedel@amd.com; iommu@lists.linux-foundation.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Wood Scott-B07421;
> Tabi Timur-B04825
> Cc: Sethi Varun-B16395
> Subject: [PATCH 1/4 v2] iommu/fsl: Store iommu domain information pointer
> in archdata.
>=20
> Add a new field in the device (powerpc) archdata structure for storing
> iommu domain information pointer. This pointer is stored when the device
> is attached to a particular domain.
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
>  arch/powerpc/include/asm/device.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/device.h
> b/arch/powerpc/include/asm/device.h
> index 77e97dd..6dc79fe 100644
> --- a/arch/powerpc/include/asm/device.h
> +++ b/arch/powerpc/include/asm/device.h
> @@ -28,6 +28,10 @@ struct dev_archdata {
>  		void		*iommu_table_base;
>  	} dma_data;
>=20
> +	/* IOMMU domain information pointer. This would be set
> +	 * when this device is attached to an iommu_domain.
> +	 */
> +	void			*iommu_domain;
>  #ifdef CONFIG_SWIOTLB
>  	dma_addr_t		max_direct_dma_addr;
>  #endif
> --
> 1.7.4.1
