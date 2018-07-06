Return-Path: <nipun.gupta@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0085.outbound.protection.outlook.com [104.47.1.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MXL85wM5zDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 21:19:08 +1000 (AEST)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: "joro@8bytes.org" <joro@8bytes.org>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
Date: Fri, 6 Jul 2018 11:18:55 +0000
Message-ID: <HE1PR0401MB24256CD990DAE3A343EF3A8AE6470@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <HE1PR0401MB24250CEFBC0B7CC919C4388AE6760@HE1PR0401MB2425.eurprd04.prod.outlook.com>
 <20180706111327.7gkerhkk6udfeirr@8bytes.org>
In-Reply-To: <20180706111327.7gkerhkk6udfeirr@8bytes.org>
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


Thanks Joro,

I will be sending it by mid of next week.

Regards,
Nipun

> -----Original Message-----
> From: joro@8bytes.org [mailto:joro@8bytes.org]
> Sent: Friday, July 6, 2018 4:43 PM
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: robin.murphy@arm.com; will.deacon@arm.com;
> gregkh@linuxfoundation.org; hch@lst.de; m.szyprowski@samsung.com;
> shawnguo@kernel.org; frowand.list@gmail.com; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linu=
x-
> pci@vger.kernel.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> stuyoder@gmail.com; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMM=
U
>=20
> Hi Nipun,
>=20
> On Thu, Jun 21, 2018 at 03:59:27AM +0000, Nipun Gupta wrote:
> > Will this patch-set be taken for the next kernel release (and via which=
 tree)?
>=20
> I can take this through IOMMU tree if nobody objects. Please work out
> the last remaining comment on patch 7 with Robin and then re-send with
> all Acks and Reviewed-by: tags included.
>=20
> Oh, and please use 'iommu/of:' prefix instead of 'iommu: of:' and follow
> that sheme for the other patches/prefixes as well.
>=20
> Thanks,
>=20
> 	Joerg
