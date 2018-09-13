Return-Path: <nipun.gupta@nxp.com>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80051.outbound.protection.outlook.com [40.107.8.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429mj02f3yzF3RN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 15:01:53 +1000 (AEST)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Will Deacon <will.deacon@arm.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMMU
Date: Thu, 13 Sep 2018 05:01:46 +0000
Message-ID: <VI1PR04MB448065E40C0930BA42FDE08DE61A0@VI1PR04MB4480.eurprd04.prod.outlook.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
 <20180912165845.GD16071@arm.com>
In-Reply-To: <20180912165845.GD16071@arm.com>
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
> From: Will Deacon [mailto:will.deacon@arm.com]
> Sent: Wednesday, September 12, 2018 10:29 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: joro@8bytes.org; robin.murphy@arm.com; robh+dt@kernel.org;
> robh@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com;
> gregkh@linuxfoundation.org; Laurentiu Tudor <laurentiu.tudor@nxp.com>;
> bhelgaas@google.com; hch@lst.de; m.szyprowski@samsung.com;
> shawnguo@kernel.org; frowand.list@gmail.com; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linu=
x-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMM=
U
>=20
> Hi Nipun,
>=20
> On Mon, Sep 10, 2018 at 07:19:14PM +0530, Nipun Gupta wrote:
> > This patchset defines IOMMU DT binding for fsl-mc bus and adds
> > support in SMMU for fsl-mc bus.
> >
> > These patches
> >   - Define property 'iommu-map' for fsl-mc bus (patch 1)
> >   - Integrates the fsl-mc bus with the SMMU using this
> >     IOMMU binding (patch 2,3,4)
> >   - Adds the dma configuration support for fsl-mc bus (patch 5, 6)
> >   - Updates the fsl-mc device node with iommu/dma related changes (patc=
h 7)
>=20
> It looks like you have all the Acks in place for this series now, so I
> assume it's going to go via Joerg directly. Is that right?

This is what I am expecting :)
=20
> Will
>=20
