Return-Path: <robherring2@gmail.com>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40b1MS6vGzzF2QQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 22:44:52 +1000 (AEST)
Received: by mail-ot0-f194.google.com with SMTP id l12-v6so12804866oth.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 May 2018 05:44:52 -0700 (PDT)
Date: Tue, 1 May 2018 07:44:49 -0500
From: Rob Herring <robh@kernel.org>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
 catalin.marinas@arm.com, gregkh@linuxfoundation.org, hch@lst.de,
 joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
 frowand.list@gmail.com, bhelgaas@google.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
 leoyang.li@nxp.com
Subject: Re: [PATCH v4 2/6] iommu: of: make of_pci_map_rid() available for
 other devices too
Message-ID: <20180501124449.GA3009@rob-hp-laptop>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-3-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525069641-8523-3-git-send-email-nipun.gupta@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 30, 2018 at 11:57:17AM +0530, Nipun Gupta wrote:
> iommu-map property is also used by devices with fsl-mc. This
> patch moves the of_pci_map_rid to generic location, so that it
> can be used by other busses too.
> 
> 'of_pci_map_rid' is renamed here to 'of_map_rid' and there is no
> functional change done in the API.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>  drivers/iommu/of_iommu.c |   5 +--
>  drivers/of/base.c        | 102 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/of/irq.c         |   5 +--
>  drivers/pci/of.c         | 101 ----------------------------------------------
>  include/linux/of.h       |  11 +++++
>  include/linux/of_pci.h   |  10 -----
>  6 files changed, 117 insertions(+), 117 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
