Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9885FC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 00:30:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4652080C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 00:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JOYv5AY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4652080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42yqVz0MXHzF3M6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 11:30:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JOYv5AY2";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yqPK3ZPDzF3Rk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 11:25:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="JOYv5AY2"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42yqPJ72lLz9sBn; Mon, 19 Nov 2018 11:25:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1542587141;
 bh=bSAO8xLojfiYyytfW/K0oXQ1HuHg1Co9PuBtc8KEOO8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JOYv5AY2mjqKTceGf07ymFc1b+jAWJcCJA88NGbXSUu+lxzSfeVtBXOv76NciwiPO
 zYjy+6fm1OlEWee6GchS+ay6rAQqcRFpcKFyjaPSaPsUzO58V1xatwxEhVQ6KY8D/W
 483nKTifP4C5biNU4HgOkhq+cXscri82sCz4TnVw=
Date: Mon, 19 Nov 2018 11:15:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 14/22] powerpc/iommu_api: Move IOMMU groups
 setup to a single place
Message-ID: <20181119001529.GA4878@umbus>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-15-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20181113082823.2440-15-aik@ozlabs.ru>
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


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:28:15PM +1100, Alexey Kardashevskiy wrote:
> Registering new IOMMU groups and adding devices to them are separated in
> code and the latter is dug in the DMA setup code which it does not
> really belong to.
>=20
> This moved IOMMU groups setup to a separate helper which registers a group
> and adds devices as before. This does not make a difference as IOMMU
> groups are not used anyway; the only dependency here is that
> iommu_add_device() requires a valid pointer to an iommu_table
> (set by set_iommu_table_base()).
>=20
> To keep the old behaviour, this does not add new IOMMU groups for PEs
> with no DMA weigth and also skips NVLINK bridges which do not have
> pci_controller_ops::setup_bridge (the normal way of adding PEs).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 80 +++++++++++++++++++----
>  1 file changed, 66 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index f36a802..7f4904a 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1269,6 +1269,8 @@ static void pnv_ioda_setup_npu_PEs(struct pci_bus *=
bus)
>  		pnv_ioda_setup_npu_PE(pdev);
>  }
> =20
> +static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe);
> +
>  static void pnv_pci_ioda_setup_PEs(void)
>  {
>  	struct pci_controller *hose;
> @@ -1591,6 +1593,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pd=
ev, u16 num_vfs)
>  		mutex_unlock(&phb->ioda.pe_list_mutex);
> =20
>  		pnv_pci_ioda2_setup_dma_pe(phb, pe);
> +		pnv_ioda_setup_bus_iommu_group(pe);
>  	}
>  }
> =20
> @@ -1930,21 +1933,16 @@ static u64 pnv_pci_ioda_dma_get_required_mask(str=
uct pci_dev *pdev)
>  	return mask;
>  }
> =20
> -static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
> -				   struct pci_bus *bus,
> -				   bool add_to_group)
> +static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bu=
s *bus)
>  {
>  	struct pci_dev *dev;
> =20
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
>  		set_dma_offset(&dev->dev, pe->tce_bypass_base);
> -		if (add_to_group)
> -			iommu_add_device(&pe->table_group, &dev->dev);
> =20
>  		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
> -			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
> -					add_to_group);
> +			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
>  	}
>  }
> =20
> @@ -2374,7 +2372,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_p=
hb *phb,
>  	iommu_init_table(tbl, phb->hose->node);
> =20
>  	if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
> -		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
> +		pnv_ioda_setup_bus_dma(pe, pe->pbus);
> =20
>  	return;
>   fail:
> @@ -2607,7 +2605,7 @@ static void pnv_ioda2_take_ownership(struct iommu_t=
able_group *table_group)
>  	pnv_pci_ioda2_set_bypass(pe, false);
>  	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
>  	if (pe->pbus)
> -		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
> +		pnv_ioda_setup_bus_dma(pe, pe->pbus);
>  	iommu_tce_table_put(tbl);
>  }
> =20
> @@ -2618,7 +2616,7 @@ static void pnv_ioda2_release_ownership(struct iomm=
u_table_group *table_group)
> =20
>  	pnv_pci_ioda2_setup_default_config(pe);
>  	if (pe->pbus)
> -		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
> +		pnv_ioda_setup_bus_dma(pe, pe->pbus);
>  }
> =20
>  static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
> @@ -2735,12 +2733,68 @@ static struct iommu_table_group_ops pnv_pci_ioda2=
_npu_ops =3D {
>  	.release_ownership =3D pnv_ioda2_release_ownership,
>  };
> =20
> +static void pnv_ioda_setup_bus_iommu_group_add_devices(struct pnv_ioda_p=
e *pe,
> +		struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		iommu_add_device(&pe->table_group, &dev->dev);
> +
> +		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
> +			pnv_ioda_setup_bus_iommu_group_add_devices(pe,
> +					dev->subordinate);
> +	}
> +}
> +
> +static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe)
> +{
> +	if (!pnv_pci_ioda_pe_dma_weight(pe))
> +		return;
> +
> +	iommu_register_group(&pe->table_group, pe->phb->hose->global_number,
> +			pe->pe_number);
> +
> +	/*
> +	 * set_iommu_table_base(&pe->pdev->dev, tbl) should have been called
> +	 * by now
> +	 */
> +	if (pe->flags & PNV_IODA_PE_DEV)
> +		iommu_add_device(&pe->table_group, &pe->pdev->dev);
> +	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
> +		pnv_ioda_setup_bus_iommu_group_add_devices(pe, pe->pbus);
> +}
> +
>  static void pnv_pci_ioda_setup_iommu_api(void)
>  {
>  	struct pci_controller *hose, *tmp;
>  	struct pnv_phb *phb;
>  	struct pnv_ioda_pe *pe, *gpe;
> =20
> +	/*
> +	 * There are 4 types of PEs:
> +	 * - PNV_IODA_PE_BUS: a downstream port with an adapter,
> +	 *   created from pnv_pci_setup_bridge();
> +	 * - PNV_IODA_PE_BUS_ALL: a PCI-PCIX bridge with devices behind it,
> +	 *   created from pnv_pci_setup_bridge();
> +	 * - PNV_IODA_PE_VF: a SRIOV virtual function,
> +	 *   created from pnv_pcibios_sriov_enable();
> +	 * - PNV_IODA_PE_DEV: an NPU or OCAPI device,
> +	 *   created from pnv_pci_ioda_fixup().
> +	 *
> +	 * Normally a PE is represented by an IOMMU group, however for
> +	 * devices with side channels the groups need to be more strict.
> +	 */
> +	list_for_each_entry(hose, &hose_list, list_node) {
> +		phb =3D hose->private_data;
> +
> +		if (phb->type =3D=3D PNV_PHB_NPU_NVLINK)
> +			continue;
> +
> +		list_for_each_entry(pe, &phb->ioda.pe_list, list)
> +			pnv_ioda_setup_bus_iommu_group(pe);
> +	}
> +
>  	/*
>  	 * Now we have all PHBs discovered, time to add NPU devices to
>  	 * the corresponding IOMMU groups.
> @@ -2759,6 +2813,7 @@ static void pnv_pci_ioda_setup_iommu_api(void)
>  	}
>  }
>  #else /* !CONFIG_IOMMU_API */
> +static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe) { }
>  static void pnv_pci_ioda_setup_iommu_api(void) { };
>  #endif
> =20
> @@ -2801,9 +2856,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  	/* TVE #1 is selected by PCI address bit 59 */
>  	pe->tce_bypass_base =3D 1ull << 59;
> =20
> -	iommu_register_group(&pe->table_group, phb->hose->global_number,
> -			pe->pe_number);
> -
>  	/* The PE will reserve all possible 32-bits space */
>  	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
>  		phb->ioda.m32_pci_base);
> @@ -2824,7 +2876,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  		return;
> =20
>  	if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
> -		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
> +		pnv_ioda_setup_bus_dma(pe, pe->pbus);
>  }
> =20
>  #ifdef CONFIG_PCI_MSI

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvyAJ8ACgkQbDjKyiDZ
s5JK5xAA4JNoeBppLUQdeE+U6quJ+j4EZIdKluqOk8q5atgZ9yH5VP0s2FioVTNC
YF5UFX1+egc7P9673k79VQqMSBZ/plKNjnTz1S2VMgkIKVv3eHL24djOeiP+4Weo
oapMRjUMv7T7x3JS0j+s29NvsPGo8Xdikr/YgGhTxeFpaLrSDp+siLzWdWCoL+9/
P8+m6pNPKgRSnKDMP57gqSPwrkyH2zEpFvsi7kwbISx0XDFLwk6p3DZj4nV/i47Z
oMP1XUGnrlLZcLVj23+dd7vJYX88Z4xVT5wEPXarZimWHXWty8uxzPRlhvMIg7Tb
1sEbK4WTA6ZuJvtXaSZXT5C7vgYfGYB58ts9xRPhjdhYuuJBotnYQsidKS8o2KrU
egPtyeTGABTeLdsQAt9664zPaIvvTbZyfEQSF4J97L30gLU2ssZGs4l9DrWC5Fop
yCPi+pPos6teRMbiLM8/9b76o+XAJEUErUcK0WWUhUbHvENuiHvReNGfJrX1TTm0
OmCKohnioQEcEcbPpoASHVouP/jHgSmdkv2dTuD1fAmHgmX5xv6xJzQLkNVNqLMQ
5EAnivqKBszigxsQbF7u6hbAXqwOAjFTFE1qpZVCY84/ZO7pvtOsiLCNCfJAl+Vx
GPOqCt6l/Izf692MNp8SEqLB3TDGWU4GBwnS6bWw7YPAAox87Mw=
=Sv77
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
