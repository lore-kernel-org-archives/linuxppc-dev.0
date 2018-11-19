Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF1BC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 01:18:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276902080C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 01:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QDY/sHdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276902080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42yrYr1fpbzF3R7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 12:18:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QDY/sHdp";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yrW51x54zF3NC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 12:15:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="QDY/sHdp"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42yrW50ZVnz9sBQ; Mon, 19 Nov 2018 12:15:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1542590145;
 bh=rH3zL5zbs0BgNssNeeOQAY8FijuDQecZPrxt7PNi77g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QDY/sHdpTkHoLYTODnidi8G368TAg32j9iGaQ+9Qrx4XszerJr9ZqFQ9jSEELL2Ce
 U+jr94HmBqZNrDPvCe26Hi/zBUICmgJMHwd+83f5f9SulcGS8xopHN0ey1Vfof7yok
 S0fjva6/m/0s94nvhUVkiDz1whCI6auZFBZTVyK0=
Date: Mon, 19 Nov 2018 12:12:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 18/22] powerpc/powernv/npu: Add compound IOMMU
 groups
Message-ID: <20181119011242.GB23503@umbus>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-19-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <20181113082823.2440-19-aik@ozlabs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:28:19PM +1100, Alexey Kardashevskiy wrote:
> At the moment powernv registers an IOMMU group for each PE. There is
> an exception though - NPU (an emulated PCI bridge representing an NVLink);
> powernv attaches these bridges to the GPU IOMMU group which becomes
> a master.
>=20
> Now we have POWER9 systems with GPUs connected to each other directly,
> bypassing PCI. At the moment powernv does not control these links so
> it has to put such interconnected GPUs to the same IOMMU group which
> means that the old scheme with a GPU as a master won't work - there will
> be up to 3 GPUs in such group.
>=20
> This introduces a npu_comp struct which represents a compound IOMMU
> group made of multiple PEs. This converts the existing NVLink1 code to
> use the new scheme. From now on, each PE must have a valid
> iommu_table_group_ops which will either be called directly (a single PE
> group) or indirectly from a compound group.
>=20
> This moves IOMMU group registration for NPU-connected GPUs to npu-dma.c.
> For POWER8, this stores a new compound group pointer in a PE (so a GPU
> is still a master); for POWER9 the new group pointer is stored in an NPU.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/pci.h            |   1 +
>  arch/powerpc/platforms/powernv/pci.h      |   7 +
>  arch/powerpc/platforms/powernv/npu-dma.c  | 286 ++++++++++++++++++++--
>  arch/powerpc/platforms/powernv/pci-ioda.c | 173 +++----------
>  4 files changed, 308 insertions(+), 159 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pc=
i.h
> index baf2886..0c72f18 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -132,5 +132,6 @@ extern struct pci_dev *pnv_pci_get_npu_dev(struct pci=
_dev *gpdev, int index);
>  extern int pnv_npu2_init(struct pci_controller *hose);
>  extern int pnv_npu2_map_lpar_dev(struct pci_dev *gpdev, unsigned int lpa=
rid,
>  		unsigned long msr);
> +extern int pnv_npu2_unmap_lpar_dev(struct pci_dev *gpdev);
> =20
>  #endif /* __ASM_POWERPC_PCI_H */
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index cf9f748..aef4bb5 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -62,6 +62,7 @@ struct pnv_ioda_pe {
> =20
>  	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
>  	struct iommu_table_group table_group;
> +	struct npu_comp		*npucomp;
> =20
>  	/* 64-bit TCE bypass region */
>  	bool			tce_bypass_enabled;
> @@ -201,6 +202,8 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *pde=
v);
>  extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
>  extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
>  extern void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable=
);
> +extern unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
> +		__u64 window_size, __u32 levels);
>  extern int pnv_eeh_post_init(void);
> =20
>  extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *le=
vel,
> @@ -216,6 +219,10 @@ extern void pe_level_printk(const struct pnv_ioda_pe=
 *pe, const char *level,
>  extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypas=
s);
>  extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, boo=
l rm);
>  extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *n=
pe);
> +extern struct iommu_table_group *pnv_try_setup_npu_table_group(
> +		struct pnv_ioda_pe *pe);
> +extern struct iommu_table_group *pnv_npu_compound_attach(
> +		struct pnv_ioda_pe *pe);
> =20
>  /* pci-ioda-tce.c */
>  #define POWERNV_IOMMU_DEFAULT_LEVELS	1
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/plat=
forms/powernv/npu-dma.c
> index 1792c7e..2231f4c 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -317,31 +317,6 @@ static struct iommu_table_group_ops pnv_pci_npu_ops =
=3D {
>  	.unset_window =3D pnv_npu_unset_window,
>  	.take_ownership =3D pnv_npu_take_ownership,
>  };
> -
> -struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
> -{
> -	struct pnv_phb *phb =3D npe->phb;
> -	struct pci_bus *pbus =3D phb->hose->bus;
> -	struct pci_dev *npdev, *gpdev =3D NULL, *gptmp;
> -	struct pnv_ioda_pe *gpe =3D get_gpu_pci_dev_and_pe(npe, &gpdev);
> -
> -	if (!gpe || !gpdev)
> -		return NULL;
> -
> -	npe->table_group.ops =3D &pnv_pci_npu_ops;
> -
> -	list_for_each_entry(npdev, &pbus->devices, bus_list) {
> -		gptmp =3D pnv_pci_get_gpu_dev(npdev);
> -
> -		if (gptmp !=3D gpdev)
> -			continue;
> -
> -		pe_info(gpe, "Attached NPU %s\n", dev_name(&npdev->dev));
> -		iommu_group_add_device(gpe->table_group.group, &npdev->dev);
> -	}
> -
> -	return gpe;
> -}
>  #endif /* !CONFIG_IOMMU_API */
> =20
>  /*
> @@ -349,6 +324,17 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct p=
nv_ioda_pe *npe)
>   */
>  /* Maximum possible number of ATSD MMIO registers per NPU */
>  #define NV_NMMU_ATSD_REGS 8
> +#define NV_NPU_MAX_PE_NUM	16
> +
> +/*
> + * A compound NPU IOMMU group which might consist of 1 GPU + 2xNPUs (POW=
ER8) or
> + * up to 3 x (GPU + 2xNPUs) (POWER9).
> + */
> +struct npu_comp {
> +	struct iommu_table_group table_group;
> +	int pe_num;
> +	struct pnv_ioda_pe *pe[NV_NPU_MAX_PE_NUM];
> +};
> =20
>  /* An NPU descriptor, valid for POWER9 only */
>  struct npu {
> @@ -365,6 +351,8 @@ struct npu {
>  	struct list_head next;
> =20
>  	struct pci_controller *hose;
> +
> +	struct npu_comp npucomp;
>  };

I'm confused by this.  The comment simply there are multiple NPUs in a
single composite-group, but the np_comp structure is embedded in the
npu structure, implying there's a copy per-NPU.


>  static LIST_HEAD(npu2_devices);
> @@ -382,6 +370,254 @@ static struct npu *npdev_to_npu(struct pci_dev *npd=
ev)
>  	return NULL;
>  }
> =20
> +#ifdef CONFIG_IOMMU_API
> +static long pnv_npu_peers_create_table_userspace(
> +		struct iommu_table_group *table_group,
> +		int num, __u32 page_shift, __u64 window_size, __u32 levels,
> +		struct iommu_table **ptbl)
> +{
> +	struct npu_comp *npucomp =3D container_of(table_group, struct npu_comp,
> +			table_group);
> +
> +	if (!npucomp->pe_num || !npucomp->pe[0] ||
> +			!npucomp->pe[0]->table_group.ops ||
> +			!npucomp->pe[0]->table_group.ops->create_table)
> +		return -EFAULT;
> +
> +	return npucomp->pe[0]->table_group.ops->create_table(
> +			&npucomp->pe[0]->table_group, num, page_shift,
> +			window_size, levels, ptbl);
> +}
> +
> +static long pnv_npu_peers_set_window(struct iommu_table_group *table_gro=
up,
> +		int num, struct iommu_table *tbl)
> +{
> +	int i, j;
> +	long ret =3D 0;
> +	struct npu_comp *npucomp =3D container_of(table_group, struct npu_comp,
> +			table_group);
> +
> +	for (i =3D 0; i < npucomp->pe_num; ++i) {
> +		struct pnv_ioda_pe *pe =3D npucomp->pe[i];
> +
> +		if (!pe->table_group.ops->set_window)
> +			continue;
> +
> +		ret =3D pe->table_group.ops->set_window(&pe->table_group,
> +				num, tbl);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (ret) {
> +		for (j =3D 0; j < i; ++j) {
> +			struct pnv_ioda_pe *pe =3D npucomp->pe[j];
> +
> +			if (!pe->table_group.ops->unset_window)
> +				continue;
> +
> +			ret =3D pe->table_group.ops->unset_window(
> +					&pe->table_group, num);
> +			if (ret)
> +				break;
> +		}
> +	} else {
> +		table_group->tables[num] =3D iommu_tce_table_get(tbl);
> +	}
> +
> +	return ret;
> +}
> +
> +static long pnv_npu_peers_unset_window(struct iommu_table_group *table_g=
roup,
> +		int num)
> +{
> +	int i, j;
> +	long ret =3D 0;
> +	struct npu_comp *npucomp =3D container_of(table_group, struct npu_comp,
> +			table_group);
> +
> +	for (i =3D 0; i < npucomp->pe_num; ++i) {
> +		struct pnv_ioda_pe *pe =3D npucomp->pe[i];
> +
> +		WARN_ON(npucomp->table_group.tables[num] !=3D
> +				table_group->tables[num]);
> +		if (!npucomp->table_group.tables[num])
> +			continue;
> +
> +		if (!pe->table_group.ops->unset_window)
> +			continue;
> +
> +		ret =3D pe->table_group.ops->unset_window(&pe->table_group, num);
> +		if (ret)
> +			break;
> +	}
> +
> +	if (ret) {
> +		for (j =3D 0; j < i; ++j) {
> +			struct pnv_ioda_pe *pe =3D npucomp->pe[j];
> +
> +			if (!npucomp->table_group.tables[num])
> +				continue;
> +
> +			if (!pe->table_group.ops->set_window)
> +				continue;
> +
> +			ret =3D pe->table_group.ops->set_window(&pe->table_group,
> +					num, table_group->tables[num]);
> +			if (ret)
> +				break;
> +		}
> +	} else if (table_group->tables[num]) {
> +		iommu_tce_table_put(table_group->tables[num]);
> +		table_group->tables[num] =3D NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +static void pnv_npu_peers_take_ownership(struct iommu_table_group *table=
_group)
> +{
> +	int i;
> +	struct npu_comp *npucomp =3D container_of(table_group, struct npu_comp,
> +			table_group);
> +
> +	for (i =3D 0; i < npucomp->pe_num; ++i) {
> +		struct pnv_ioda_pe *pe =3D npucomp->pe[i];
> +
> +		if (!pe->table_group.ops->take_ownership)
> +			continue;
> +		pe->table_group.ops->take_ownership(&pe->table_group);
> +	}
> +}
> +
> +static void pnv_npu_peers_release_ownership(
> +		struct iommu_table_group *table_group)
> +{
> +	int i;
> +	struct npu_comp *npucomp =3D container_of(table_group, struct npu_comp,
> +			table_group);
> +
> +	for (i =3D 0; i < npucomp->pe_num; ++i) {
> +		struct pnv_ioda_pe *pe =3D npucomp->pe[i];
> +
> +		if (!pe->table_group.ops->release_ownership)
> +			continue;
> +		pe->table_group.ops->release_ownership(&pe->table_group);
> +	}
> +}
> +
> +static struct iommu_table_group_ops pnv_npu_peers_ops =3D {
> +	.get_table_size =3D pnv_pci_ioda2_get_table_size,
> +	.create_table =3D pnv_npu_peers_create_table_userspace,
> +	.set_window =3D pnv_npu_peers_set_window,
> +	.unset_window =3D pnv_npu_peers_unset_window,
> +	.take_ownership =3D pnv_npu_peers_take_ownership,
> +	.release_ownership =3D pnv_npu_peers_release_ownership,
> +};
> +
> +static void pnv_comp_attach_table_group(struct npu_comp *npucomp,
> +		struct pnv_ioda_pe *pe)
> +{
> +	if (WARN_ON(npucomp->pe_num =3D=3D NV_NPU_MAX_PE_NUM))
> +		return;
> +
> +	npucomp->pe[npucomp->pe_num] =3D pe;
> +	++npucomp->pe_num;
> +}
> +
> +struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_=
pe *pe)
> +{
> +	struct iommu_table_group *table_group;
> +	struct npu *npu;
> +	struct npu_comp *npucomp;
> +	struct pci_dev *gpdev =3D NULL;
> +	struct pci_controller *hose;
> +	struct pci_dev *npdev;
> +
> +	list_for_each_entry(gpdev, &pe->pbus->devices, bus_list) {
> +		npdev =3D pnv_pci_get_npu_dev(gpdev, 0);
> +		if (npdev)
> +			break;
> +	}
> +
> +	if (!npdev)
> +		/* It is not an NPU attached device, skip */
> +		return NULL;
> +
> +	hose =3D pci_bus_to_host(gpdev->bus);
> +	npu =3D npdev_to_npu(npdev);
> +	if (npu) {
> +		table_group =3D &npu->npucomp.table_group;
> +
> +		if (!table_group->group) {
> +			table_group->ops =3D &pnv_npu_peers_ops;
> +			iommu_register_group(table_group,
> +					hose->global_number,
> +					pe->pe_number);
> +		}
> +	} else {
> +		/* Create a group for 1 GPU and attached NPUs */
> +		pe->npucomp =3D kzalloc(sizeof(pe->npucomp), GFP_KERNEL);
> +		table_group =3D &pe->npucomp->table_group;
> +		table_group->ops =3D &pnv_npu_peers_ops;
> +		iommu_register_group(table_group, hose->global_number,
> +				pe->pe_number);
> +	}
> +
> +	/* Steal capabilities from a GPU PE */
> +	table_group->max_dynamic_windows_supported =3D
> +		pe->table_group.max_dynamic_windows_supported;
> +	table_group->tce32_start =3D pe->table_group.tce32_start;
> +	table_group->tce32_size =3D pe->table_group.tce32_size;
> +	table_group->max_levels =3D pe->table_group.max_levels;
> +	table_group->pgsizes =3D pe->table_group.pgsizes;
> +
> +	npucomp =3D container_of(table_group, struct npu_comp, table_group);
> +	pnv_comp_attach_table_group(npucomp, pe);
> +
> +	return table_group;
> +}
> +
> +struct iommu_table_group *pnv_npu_compound_attach(struct pnv_ioda_pe *pe)
> +{
> +	struct iommu_table_group *table_group;
> +	struct npu_comp *npucomp;
> +	struct pci_dev *gpdev =3D NULL;
> +	struct pci_dev *npdev;
> +	struct pnv_ioda_pe *gpe =3D get_gpu_pci_dev_and_pe(pe, &gpdev);
> +
> +	WARN_ON(!(pe->flags & PNV_IODA_PE_DEV));
> +	if (!gpe)
> +		return NULL;
> +
> +	/*
> +	 * IODA2 bridges get this set up from
> +	 * pci_controller_ops::setup_bridge but NPU bridges do not
> +	 * have this hook defined so we do it here.
> +	 */
> +	pe->table_group.max_dynamic_windows_supported =3D
> +		IOMMU_TABLE_GROUP_MAX_TABLES;
> +	pe->table_group.ops =3D &pnv_pci_npu_ops;
> +
> +	table_group =3D iommu_group_get_iommudata(
> +			iommu_group_get(&gpdev->dev));
> +
> +	npucomp =3D container_of(table_group, struct npu_comp, table_group);
> +	pnv_comp_attach_table_group(npucomp, pe);
> +
> +	list_for_each_entry(npdev, &pe->phb->hose->bus->devices, bus_list) {
> +		struct pci_dev *gpdevtmp =3D pnv_pci_get_gpu_dev(npdev);
> +
> +		if (gpdevtmp !=3D gpdev)
> +			continue;
> +
> +		iommu_add_device(table_group, &npdev->dev);
> +	}
> +
> +	return table_group;
> +}
> +#endif /* CONFIG_IOMMU_API */
> +
>  /* Maximum number of nvlinks per npu */
>  #define NV_MAX_LINKS 6
> =20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 04639ae..0e8ada5 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -190,7 +190,8 @@ static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe)
>  	unsigned int pe_num =3D pe->pe_number;
> =20
>  	WARN_ON(pe->pdev);
> -
> +	WARN_ON(pe->npucomp);
> +	kfree(pe->npucomp);
>  	memset(pe, 0, sizeof(struct pnv_ioda_pe));
>  	clear_bit(pe_num, phb->ioda.pe_alloc);
>  }
> @@ -1269,7 +1270,8 @@ static void pnv_ioda_setup_npu_PEs(struct pci_bus *=
bus)
>  		pnv_ioda_setup_npu_PE(pdev);
>  }
> =20
> -static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe);
> +static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe,
> +		struct iommu_table_group *table_group, struct pci_bus *bus);
> =20
>  static void pnv_pci_ioda_setup_PEs(void)
>  {
> @@ -1593,7 +1595,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pd=
ev, u16 num_vfs)
>  		mutex_unlock(&phb->ioda.pe_list_mutex);
> =20
>  		pnv_pci_ioda2_setup_dma_pe(phb, pe);
> -		pnv_ioda_setup_bus_iommu_group(pe);
> +		pnv_ioda_setup_bus_iommu_group(pe, &pe->table_group, NULL);
>  	}
>  }
> =20
> @@ -2554,7 +2556,7 @@ static long pnv_pci_ioda2_unset_window(struct iommu=
_table_group *table_group,
>  #endif
> =20
>  #ifdef CONFIG_IOMMU_API
> -static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
> +unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
>  		__u64 window_size, __u32 levels)
>  {
>  	unsigned long bytes =3D 0;
> @@ -2628,147 +2630,38 @@ static struct iommu_table_group_ops pnv_pci_ioda=
2_ops =3D {
>  	.release_ownership =3D pnv_ioda2_release_ownership,
>  };
> =20
> -static int gpe_table_group_to_npe_cb(struct device *dev, void *opaque)
> -{
> -	struct pci_controller *hose;
> -	struct pnv_phb *phb;
> -	struct pnv_ioda_pe **ptmppe =3D opaque;
> -	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> -	struct pci_dn *pdn =3D pci_get_pdn(pdev);
> -
> -	if (!pdn || pdn->pe_number =3D=3D IODA_INVALID_PE)
> -		return 0;
> -
> -	hose =3D pci_bus_to_host(pdev->bus);
> -	phb =3D hose->private_data;
> -	if (phb->type !=3D PNV_PHB_NPU_NVLINK)
> -		return 0;
> -
> -	*ptmppe =3D &phb->ioda.pe_array[pdn->pe_number];
> -
> -	return 1;
> -}
> -
> -/*
> - * This returns PE of associated NPU.
> - * This assumes that NPU is in the same IOMMU group with GPU and there is
> - * no other PEs.
> - */
> -static struct pnv_ioda_pe *gpe_table_group_to_npe(
> -		struct iommu_table_group *table_group)
> -{
> -	struct pnv_ioda_pe *npe =3D NULL;
> -	int ret =3D iommu_group_for_each_dev(table_group->group, &npe,
> -			gpe_table_group_to_npe_cb);
> -
> -	BUG_ON(!ret || !npe);
> -
> -	return npe;
> -}
> -
> -static long pnv_pci_ioda2_npu_set_window(struct iommu_table_group *table=
_group,
> -		int num, struct iommu_table *tbl)
> -{
> -	struct pnv_ioda_pe *npe =3D gpe_table_group_to_npe(table_group);
> -	int num2 =3D (num =3D=3D 0) ? 1 : 0;
> -	long ret =3D pnv_pci_ioda2_set_window(table_group, num, tbl);
> -
> -	if (ret)
> -		return ret;
> -
> -	if (table_group->tables[num2])
> -		npe->table_group.ops->unset_window(&npe->table_group, num2);
> -
> -	ret =3D npe->table_group.ops->set_window(&npe->table_group, num, tbl);
> -	if (ret) {
> -		pnv_pci_ioda2_unset_window(table_group, num);
> -		if (table_group->tables[num2])
> -			npe->table_group.ops->set_window(&npe->table_group,
> -					num2, table_group->tables[num2]);
> -	}
> -
> -	return ret;
> -}
> -
> -static long pnv_pci_ioda2_npu_unset_window(
> -		struct iommu_table_group *table_group,
> -		int num)
> -{
> -	struct pnv_ioda_pe *npe =3D gpe_table_group_to_npe(table_group);
> -	int num2 =3D (num =3D=3D 0) ? 1 : 0;
> -	long ret =3D pnv_pci_ioda2_unset_window(table_group, num);
> -
> -	if (ret)
> -		return ret;
> -
> -	if (!npe->table_group.tables[num])
> -		return 0;
> -
> -	ret =3D npe->table_group.ops->unset_window(&npe->table_group, num);
> -	if (ret)
> -		return ret;
> -
> -	if (table_group->tables[num2])
> -		ret =3D npe->table_group.ops->set_window(&npe->table_group, num2,
> -				table_group->tables[num2]);
> -
> -	return ret;
> -}
> -
> -static void pnv_ioda2_npu_take_ownership(struct iommu_table_group *table=
_group)
> -{
> -	struct pnv_ioda_pe *npe =3D gpe_table_group_to_npe(table_group);
> -
> -	npe->table_group.ops->take_ownership(&npe->table_group);
> -	pnv_ioda2_take_ownership(table_group);
> -}
> -
> -static struct iommu_table_group_ops pnv_pci_ioda2_npu_ops =3D {
> -	.get_table_size =3D pnv_pci_ioda2_get_table_size,
> -	.create_table =3D pnv_pci_ioda2_create_table_userspace,
> -	.set_window =3D pnv_pci_ioda2_npu_set_window,
> -	.unset_window =3D pnv_pci_ioda2_npu_unset_window,
> -	.take_ownership =3D pnv_ioda2_npu_take_ownership,
> -	.release_ownership =3D pnv_ioda2_release_ownership,
> -};
> -
>  static void pnv_ioda_setup_bus_iommu_group_add_devices(struct pnv_ioda_p=
e *pe,
> +		struct iommu_table_group *table_group,
>  		struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
> =20
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		iommu_add_device(&pe->table_group, &dev->dev);
> +		iommu_add_device(table_group, &dev->dev);
> =20
>  		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
>  			pnv_ioda_setup_bus_iommu_group_add_devices(pe,
> -					dev->subordinate);
> +					table_group, dev->subordinate);
>  	}
>  }
> =20
> -static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe)
> +static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe,
> +		struct iommu_table_group *table_group, struct pci_bus *bus)
>  {
> -	if (!pnv_pci_ioda_pe_dma_weight(pe))
> -		return;
> =20
> -	iommu_register_group(&pe->table_group, pe->phb->hose->global_number,
> -			pe->pe_number);
> -
> -	/*
> -	 * set_iommu_table_base(&pe->pdev->dev, tbl) should have been called
> -	 * by now
> -	 */
>  	if (pe->flags & PNV_IODA_PE_DEV)
> -		iommu_add_device(&pe->table_group, &pe->pdev->dev);
> -	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
> -		pnv_ioda_setup_bus_iommu_group_add_devices(pe, pe->pbus);
> +		iommu_add_device(table_group, &pe->pdev->dev);
> +
> +	if ((pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) || bus)
> +		pnv_ioda_setup_bus_iommu_group_add_devices(pe, table_group,
> +				bus);
>  }
> =20
>  static void pnv_pci_ioda_setup_iommu_api(void)
>  {
> -	struct pci_controller *hose, *tmp;
> +	struct pci_controller *hose;
>  	struct pnv_phb *phb;
> -	struct pnv_ioda_pe *pe, *gpe;
> +	struct pnv_ioda_pe *pe;
> =20
>  	/*
>  	 * There are 4 types of PEs:
> @@ -2790,29 +2683,41 @@ static void pnv_pci_ioda_setup_iommu_api(void)
>  		if (phb->type =3D=3D PNV_PHB_NPU_NVLINK)
>  			continue;
> =20
> -		list_for_each_entry(pe, &phb->ioda.pe_list, list)
> -			pnv_ioda_setup_bus_iommu_group(pe);
> +		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
> +			struct iommu_table_group *table_group;
> +
> +			table_group =3D pnv_try_setup_npu_table_group(pe);
> +			if (!table_group) {
> +				if (!pnv_pci_ioda_pe_dma_weight(pe))
> +					continue;
> +
> +				table_group =3D &pe->table_group;
> +				iommu_register_group(&pe->table_group,
> +						pe->phb->hose->global_number,
> +						pe->pe_number);
> +			}
> +			pnv_ioda_setup_bus_iommu_group(pe, table_group,
> +					pe->pbus);
> +		}
>  	}
> =20
>  	/*
>  	 * Now we have all PHBs discovered, time to add NPU devices to
>  	 * the corresponding IOMMU groups.
>  	 */
> -	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> +	list_for_each_entry(hose, &hose_list, list_node) {
>  		phb =3D hose->private_data;
> =20
>  		if (phb->type !=3D PNV_PHB_NPU_NVLINK)
>  			continue;
> =20
> -		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
> -			gpe =3D pnv_pci_npu_setup_iommu(pe);
> -			if (gpe)
> -				gpe->table_group.ops =3D &pnv_pci_ioda2_npu_ops;
> -		}
> +		list_for_each_entry(pe, &phb->ioda.pe_list, list)
> +			pnv_npu_compound_attach(pe);
>  	}
>  }
>  #else /* !CONFIG_IOMMU_API */
> -static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe) { }
> +static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe,
> +		struct iommu_table_group *table_group, struct pci_bus *bus){}
>  static void pnv_pci_ioda_setup_iommu_api(void) { };
>  #endif
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvyDggACgkQbDjKyiDZ
s5IYvxAAosIJU9NQH+B5hfVQrb/jYoALjCT4IHqbrFIcEuCkbHoPcjHRtV4o+8g+
O/mtuQHyA9upnrv11FCzDFID9yE6qGnikV8pfG2FfeNkhTxQBvrB8a3s50eOqTPl
LBGxiGYLE7q+la7IErnIOZ1O/WC905exlx1C/JBekiNdgEENfS0N6pfEu10wrxvT
KEtQCd8CiF0kY0HcuL0e0xpv2twGkPpPNbt2c1UuMu9uPZaovGj85T01jdcMic4h
5mRA2iBGec3ELtfebgT4Wir4RaX66c5N5X6YQd1qzrOZB1kjZqXoEvU6060l4SIS
mK3cWAdsGZUzDFMdDEX/urlDSHZ/oncwMqjT6QutOJgXZvxd8hsVXcqKAVx1C4P8
yCfBcZdTgnVF8rGwrQlyZKl1MHBEfWgfzsUrYIFVMsceM6MsYoG2fqZXCRmBuEFh
C0pZKD+23CwI/rOi6sNQTbPhkrCvfZrZVmg1TffhrUKWWDVCVNIDhDdY2T/MwaUx
Grb+yGdkc2nrhSxdx0vMIvnJgzVyjcHFqUUC7ZNtoyfeZl4gjVv/PpcEXDPkpeZQ
KD85HY7kL1htkgXU3SCHFEztK/gENqTByYTzO81c2dtwV2nBcj/L6IiZfd3eX1KA
7h0814hBETc44nBlbXTwF+BlV1JI5uxRfBFLNbDtXCUx4vJ0j3s=
=fI7I
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
