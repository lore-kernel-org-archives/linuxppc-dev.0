Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468ACC4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 23:58:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5340120882
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 23:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YmMewmLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5340120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44b0JJ5YBHzDqRw
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 10:58:08 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44b0Gd3QLczDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 10:56:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="YmMewmLf"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44b0Gd1lQPz9sPp; Fri,  5 Apr 2019 10:56:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1554422201;
 bh=DFi/TObA/vLQUxMtJVXg+GK0OCFffIddamNt3QoV0fw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YmMewmLfNyy4TbR6G9d4udgfanWk0yFCdNmKMd7i1hKtbCU0k5lUXwVLMYDyvPA7r
 uIuC5qVGr/VGKrCiLgugFm7vgkK+DKB9fmzTJSeAVsNW3ij9Qcwx3E1bHvvD0wo6xT
 czTolu1ev+mCU8v40shRZLMv6ClZ0DgkK9Oj0U1c=
Date: Fri, 5 Apr 2019 10:56:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH kernel v2] powerpc/powernv: Isolate NVLinks between
 GV100GL on Witherspoon
Message-ID: <20190404235630.GC25513@umbus.fritz.box>
References: <20190404052324.90501-1-aik@ozlabs.ru>
 <20190404142225.371fe38a@x1.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <20190404142225.371fe38a@x1.home>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 02:22:25PM -0600, Alex Williamson wrote:
> On Thu,  4 Apr 2019 16:23:24 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > The NVIDIA V100 SXM2 GPUs are connected to the CPU via PCIe links and
> > (on POWER9) NVLinks. In addition to that, GPUs themselves have direct
> > peer to peer NVLinks in groups of 2 to 4 GPUs. At the moment the POWERNV
> > platform puts all interconnected GPUs to the same IOMMU group.
> >=20
> > However the user may want to pass individual GPUs to the userspace so
> > in order to do so we need to put them into separate IOMMU groups and
> > cut off the interconnects.
> >=20
> > Thankfully V100 GPUs implement an interface to do by programming link
> > disabling mask to BAR0 of a GPU. Once a link is disabled in a GPU using
> > this interface, it cannot be re-enabled until the secondary bus reset is
> > issued to the GPU.
> >=20
> > This adds an extra step to the secondary bus reset handler (the one used
> > for such GPUs) to block NVLinks to GPUs which do not belong to the same
> > group as the GPU being reset.
> >=20
> > This adds a new "isolate_nvlink" kernel parameter to allow GPU isolatio=
n;
> > when enabled, every GPU gets its own IOMMU group. The new parameter is =
off
> > by default to preserve the existing behaviour.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > Changes:
> > v2:
> > * this is rework of [PATCH kernel RFC 0/2] vfio, powerpc/powernv: Isola=
te GV100GL
> > but this time it is contained in the powernv platform
> > ---
> >  arch/powerpc/platforms/powernv/Makefile      |   2 +-
> >  arch/powerpc/platforms/powernv/pci.h         |   1 +
> >  arch/powerpc/platforms/powernv/eeh-powernv.c |   1 +
> >  arch/powerpc/platforms/powernv/npu-dma.c     |  24 +++-
> >  arch/powerpc/platforms/powernv/nvlinkgpu.c   | 131 +++++++++++++++++++
> >  5 files changed, 156 insertions(+), 3 deletions(-)
> >  create mode 100644 arch/powerpc/platforms/powernv/nvlinkgpu.c
> >=20
> > diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/pla=
tforms/powernv/Makefile
> > index da2e99efbd04..60a10d3b36eb 100644
> > --- a/arch/powerpc/platforms/powernv/Makefile
> > +++ b/arch/powerpc/platforms/powernv/Makefile
> > @@ -6,7 +6,7 @@ obj-y			+=3D opal-msglog.o opal-hmi.o opal-power.o opal=
-irqchip.o
> >  obj-y			+=3D opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups=
=2Eo
> > =20
> >  obj-$(CONFIG_SMP)	+=3D smp.o subcore.o subcore-asm.o
> > -obj-$(CONFIG_PCI)	+=3D pci.o pci-ioda.o npu-dma.o pci-ioda-tce.o
> > +obj-$(CONFIG_PCI)	+=3D pci.o pci-ioda.o npu-dma.o pci-ioda-tce.o nvlin=
kgpu.o
> >  obj-$(CONFIG_CXL_BASE)	+=3D pci-cxl.o
> >  obj-$(CONFIG_EEH)	+=3D eeh-powernv.o
> >  obj-$(CONFIG_PPC_SCOM)	+=3D opal-xscom.o
> > diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platfo=
rms/powernv/pci.h
> > index 8e36da379252..9fd3f391482c 100644
> > --- a/arch/powerpc/platforms/powernv/pci.h
> > +++ b/arch/powerpc/platforms/powernv/pci.h
> > @@ -250,5 +250,6 @@ extern void pnv_pci_unlink_table_and_group(struct i=
ommu_table *tbl,
> >  extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
> >  		void *tce_mem, u64 tce_size,
> >  		u64 dma_offset, unsigned int page_shift);
> > +extern void pnv_try_isolate_nvidia_v100(struct pci_dev *gpdev);
> > =20
> >  #endif /* __POWERNV_PCI_H */
> > diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerp=
c/platforms/powernv/eeh-powernv.c
> > index f38078976c5d..464b097d9635 100644
> > --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> > +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> > @@ -937,6 +937,7 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *de=
v)
> >  		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> >  		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
> >  	}
> > +	pnv_try_isolate_nvidia_v100(dev);
> >  }
> > =20
> >  static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, const char *t=
ype,
> > diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/pl=
atforms/powernv/npu-dma.c
> > index dc23d9d2a7d9..017eae8197e7 100644
> > --- a/arch/powerpc/platforms/powernv/npu-dma.c
> > +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> > @@ -529,6 +529,23 @@ static void pnv_comp_attach_table_group(struct npu=
_comp *npucomp,
> >  	++npucomp->pe_num;
> >  }
> > =20
> > +static bool isolate_nvlink;
> > +
> > +static int __init parse_isolate_nvlink(char *p)
> > +{
> > +	bool val;
> > +
> > +	if (!p)
> > +		val =3D true;
> > +	else if (kstrtobool(p, &val))
> > +		return -EINVAL;
> > +
> > +	isolate_nvlink =3D val;
> > +
> > +	return 0;
> > +}
> > +early_param("isolate_nvlink", parse_isolate_nvlink);
> > +
> >  struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_iod=
a_pe *pe)
> >  {
> >  	struct iommu_table_group *table_group;
> > @@ -549,7 +566,7 @@ struct iommu_table_group *pnv_try_setup_npu_table_g=
roup(struct pnv_ioda_pe *pe)
> > =20
> >  	hose =3D pci_bus_to_host(npdev->bus);
> > =20
> > -	if (hose->npu) {
> > +	if (hose->npu && !isolate_nvlink) {
> >  		table_group =3D &hose->npu->npucomp.table_group;
> > =20
> >  		if (!table_group->group) {
> > @@ -559,7 +576,10 @@ struct iommu_table_group *pnv_try_setup_npu_table_=
group(struct pnv_ioda_pe *pe)
> >  					pe->pe_number);
> >  		}
> >  	} else {
> > -		/* Create a group for 1 GPU and attached NPUs for POWER8 */
> > +		/*
> > +		 * Create a group for 1 GPU and attached NPUs for
> > +		 * POWER8 (always) or POWER9 (when isolate_nvlink).
> > +		 */
> >  		pe->npucomp =3D kzalloc(sizeof(*pe->npucomp), GFP_KERNEL);
> >  		table_group =3D &pe->npucomp->table_group;
> >  		table_group->ops =3D &pnv_npu_peers_ops;
> > diff --git a/arch/powerpc/platforms/powernv/nvlinkgpu.c b/arch/powerpc/=
platforms/powernv/nvlinkgpu.c
> > new file mode 100644
> > index 000000000000..dbd8e9d47a05
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/powernv/nvlinkgpu.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * A helper to disable NVLinks between GPUs on IBM Withersponn platfor=
m.
> > + *
> > + * Copyright (C) 2019 IBM Corp.  All rights reserved.
> > + *     Author: Alexey Kardashevskiy <aik@ozlabs.ru>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/of.h>
> > +#include <linux/iommu.h>
> > +#include <linux/pci.h>
> > +
> > +static int nvlinkgpu_is_ph_in_group(struct device *dev, void *data)
> > +{
> > +	return dev->of_node->phandle =3D=3D *(phandle *) data;
> > +}
> > +
> > +static u32 nvlinkgpu_get_disable_mask(struct device *dev)
> > +{
> > +	int npu, peer;
> > +	u32 mask;
> > +	struct device_node *dn;
> > +	struct iommu_group *group;
> > +
> > +	dn =3D dev->of_node;
> > +	if (!of_find_property(dn, "ibm,nvlink-peers", NULL))
> > +		return 0;
> > +
> > +	group =3D iommu_group_get(dev);
> > +	if (!group)
> > +		return 0;
> > +
> > +	/*
> > +	 * Collect links to keep which includes links to NPU and links to
> > +	 * other GPUs in the same IOMMU group.
> > +	 */
> > +	for (npu =3D 0, mask =3D 0; ; ++npu) {
> > +		u32 npuph =3D 0;
> > +
> > +		if (of_property_read_u32_index(dn, "ibm,npu", npu, &npuph))
> > +			break;
> > +
> > +		for (peer =3D 0; ; ++peer) {
> > +			u32 peerph =3D 0;
> > +
> > +			if (of_property_read_u32_index(dn, "ibm,nvlink-peers",
> > +					peer, &peerph))
> > +				break;
> > +
> > +			if (peerph !=3D npuph &&
> > +				!iommu_group_for_each_dev(group, &peerph,
> > +					nvlinkgpu_is_ph_in_group))
> > +				continue;
> > +
> > +			mask |=3D 1 << (peer + 16);
> > +		}
> > +	}
> > +	iommu_group_put(group);
> > +
> > +	/* Disabling mechanism takes links to disable so invert it here */
> > +	mask =3D ~mask & 0x3F0000;
> > +
> > +	return mask;
> > +}
> > +
> > +void pnv_try_isolate_nvidia_v100(struct pci_dev *bridge)
> > +{
> > +	u32 mask;
> > +	void __iomem *bar0_0, *bar0_120000, *bar0_a00000;
> > +	struct pci_dev *pdev;
> > +
> > +	if (!bridge->subordinate)
> > +		return;
> > +
> > +	pdev =3D list_first_entry_or_null(&bridge->subordinate->devices,
> > +			struct pci_dev, bus_list);
> > +	if (!pdev)
> > +		return;
> > +
> > +	if (pdev->vendor !=3D PCI_VENDOR_ID_NVIDIA)
> > +		return;
> > +
> > +	mask =3D nvlinkgpu_get_disable_mask(&pdev->dev);
> > +	if (!mask)
> > +		return;
> > +
> > +	bar0_0 =3D pci_iomap_range(pdev, 0, 0, 0x10000);
> > +	bar0_120000 =3D pci_iomap_range(pdev, 0, 0x120000, 0x10000);
> > +	bar0_a00000 =3D pci_iomap_range(pdev, 0, 0xA00000, 0x10000);
> > +
> > +	if (bar0_120000 && bar0_0 && bar0_a00000) {
> > +		u32 val;
> > +		u16 cmd =3D 0, cmdmask =3D PCI_COMMAND_MEMORY;
> > +
> > +		pci_restore_state(pdev);
> > +		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> > +		if ((cmd & cmdmask) !=3D cmdmask)
> > +			pci_write_config_word(pdev, PCI_COMMAND, cmd | cmdmask);
> > +
> > +		/*
> > +		 * The sequence is from "Tesla P100 and V100 SXM2 NVLink
> > +		 * Isolation on Multi-Tenant Systems".
> > +		 * The register names are not provided there either,
> > +		 * hence raw values.
> > +		 */
> > +		iowrite32(0x4, bar0_120000 + 0x4C);
> > +		iowrite32(0x2, bar0_120000 + 0x2204);
> > +		val =3D ioread32(bar0_0 + 0x200);
> > +		val |=3D 0x02000000;
> > +		iowrite32(val, bar0_0 + 0x200);
> > +		val =3D ioread32(bar0_a00000 + 0x148);
> > +		val |=3D mask;
> > +		iowrite32(val, bar0_a00000 + 0x148);
> > +
> > +		if ((cmd | cmdmask) !=3D cmd)
> > +			pci_write_config_word(pdev, PCI_COMMAND, cmd);
> > +	}
> > +
>=20
>=20
> It's a little troubling that if something goes wrong with an iomap
> we'll silently fail to re-enable the expected isolation.  Seems worthy
> of at least a pci_warn/err.  Thanks,

Agreed, but apart from that LGTM.

Regardless of Alex and my disagreement on what the best way to handle
this long term is, this seems like a reasonable interim approach.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlymmawACgkQbDjKyiDZ
s5JXuBAAl1Qn5tJsTOxFmLggFPZoSOoN7hJVIgf9CBDeaK9QFtRJ6B4mHDDDIeRz
VKb8uiqHC4YlhgUZbgXPBzTIhuucYcYSRyD9gLG6KBTZNXr5lBZzHZVkbhaI5D60
Vv4fFuHZEhCFQ56DWnm+issneYJoBgbHCMKMtrzZJippHSMjwuaJE4Nor5YNzBnl
zcKrOHG+MvHHVMDVn327Xw38+nJcCvxhxiTUstatDdmKXn0BSu+tPscgHtAwVs4l
o6RpdelPdtf+67I47IwRARKE/RHLvaJTJN7k8uTqOu5Fph9zu9/5H9A9+t4sAeLN
9csL2CudIW4yF0qqbqf74Ei9U0t2mT2eiA7Ne7CdE+31ywK34VHjNSCm8bQHaK0j
wd/MukH9mLrjLcol8lITmDd2LVHCX41e1B39SYqsoQKv5S3qosa6lXYRYPn8jkSR
quYuOqClhjjDjkZd+hO3eVf70BwPeDZza7k4x9k3/HwC5R1st3GGDJQvjqkAnmCj
HOAxFlJqJW/DpUw5eF3wG3zmndNkU2Xz5DZLGaP4qJtHk0dR4AC69PrxhWVf08Am
94EdJ44gQcdA+UqHwymm/kYBveBcgQaiHoMCaIBtLuK7oaE3uHMnwjgrGmpiFj1Z
NfPtG7VBrGtMWxsbq4Qd661fwXIsyG8RgVwACCxuWKODqHVSjSE=
=Mnnn
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
