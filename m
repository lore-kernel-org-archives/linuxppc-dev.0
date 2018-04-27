Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XdgK6LZ8zF24D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2018 01:50:13 +1000 (AEST)
Date: Fri, 27 Apr 2018 17:52:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
 catalin.marinas@arm.com, hch@lst.de, gregkh@linuxfoundation.org,
 joro@8bytes.org, robh+dt@kernel.org, m.szyprowski@samsung.com,
 shawnguo@kernel.org, frowand.list@gmail.com, bhelgaas@google.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com,
 leoyang.li@nxp.com
Subject: Re: [PATCH 0/6 v3] Support for fsl-mc bus and its devices in SMMU
Message-ID: <20180427155203.GA9201@lst.de>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 27, 2018 at 03:57:00PM +0530, Nipun Gupta wrote:
> This patchset defines IOMMU DT binding for fsl-mc bus and adds
> support in SMMU for fsl-mc bus.
> 
> This patch series is dependent on patset:
> https://patchwork.kernel.org/patch/10317337/

Which still needs to be resent against 4.17-rc..
