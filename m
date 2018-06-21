Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 41BKWD1rvQzF0tX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 21:40:03 +1000 (AEST)
Date: Thu, 21 Jun 2018 12:40:35 +0100
From: Will Deacon <will.deacon@arm.com>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "hch@lst.de" <hch@lst.de>, "joro@8bytes.org" <joro@8bytes.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
Message-ID: <20180621114034.GD22505@arm.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <HE1PR0401MB24250CEFBC0B7CC919C4388AE6760@HE1PR0401MB2425.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <HE1PR0401MB24250CEFBC0B7CC919C4388AE6760@HE1PR0401MB2425.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nipun,

On Thu, Jun 21, 2018 at 03:59:27AM +0000, Nipun Gupta wrote:
> Will this patch-set be taken for the next kernel release (and via which
> tree)?

I think you need Acks from Robin and Joerg in order for this to be queued.
Robin should be back at the beginning of next month, so there's still time
for 4.19.

Will
