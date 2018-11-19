Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1250DC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 00:32:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851A12080C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 00:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Epz4lnJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851A12080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42yqYg5q7pzF3LS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 11:32:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Epz4lnJG";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yqPL0ChdzF3Rq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 11:25:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Epz4lnJG"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42yqPK3lmpz9sCX; Mon, 19 Nov 2018 11:25:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1542587141;
 bh=kLhrWqtE19uFAlngsn/7E1kLk8tM8/j5N8OSf3dWcs8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Epz4lnJGzK/BV7JaxhU0zyrwajqmkO1TVBObk6CZO2pSoGnKRt1GkigCJawstj5Rh
 kLviLwh6u7cwdjiKBKp3v1QVzwqDKUPGCm/hQVsLQ1dfe4cU5Vsg/rrgpaCIju7q6L
 OFdzAx5SAXmpYFoTgJZXRCqS3yLPXGJZ82B2L2/M=
Date: Mon, 19 Nov 2018 11:24:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 17/22] powerpc/powernv/npu: Convert NPU IOMMU
 helpers to iommu_table_group_ops
Message-ID: <20181119002410.GD4878@umbus>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-18-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <20181113082823.2440-18-aik@ozlabs.ru>
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


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:28:18PM +1100, Alexey Kardashevskiy wrote:
> At the moment NPU IOMMU is manipulated directly from the IODA2 PCI
> PE code; PCI PE acts as a master to NPU PE. Soon we will have compound
> IOMMU groups with several PEs from several different PHB (such as
> interconnected GPUs and NPUs) so there will be no single master but
> a one big IOMMU group.
>=20
> This makes a first step and converts an NPU PE to a table group.
>=20
> This should cause no behavioral change. Note that
> pnv_npu_release_ownership() has never been implemented.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci.h      |  5 ----
>  arch/powerpc/platforms/powernv/npu-dma.c  | 29 ++++++++++++++++++-----
>  arch/powerpc/platforms/powernv/pci-ioda.c | 17 +++++++------
>  3 files changed, 33 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index ddb4f02..cf9f748 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -216,11 +216,6 @@ extern void pe_level_printk(const struct pnv_ioda_pe=
 *pe, const char *level,
>  extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypas=
s);
>  extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, boo=
l rm);
>  extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *n=
pe);
> -extern long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
> -		struct iommu_table *tbl);
> -extern long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num);
> -extern void pnv_npu_take_ownership(struct pnv_ioda_pe *npe);
> -extern void pnv_npu_release_ownership(struct pnv_ioda_pe *npe);
> =20
>  /* pci-ioda-tce.c */
>  #define POWERNV_IOMMU_DEFAULT_LEVELS	1
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/plat=
forms/powernv/npu-dma.c
> index 4b60f43..1792c7e 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -121,9 +121,11 @@ static struct pnv_ioda_pe *get_gpu_pci_dev_and_pe(st=
ruct pnv_ioda_pe *npe,
>  	return pe;
>  }
> =20
> -long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
> +static long pnv_npu_set_window(struct iommu_table_group *table_group, in=
t num,
>  		struct iommu_table *tbl)
>  {
> +	struct pnv_ioda_pe *npe =3D container_of(table_group, struct pnv_ioda_p=
e,
> +			table_group);
>  	struct pnv_phb *phb =3D npe->phb;
>  	int64_t rc;
>  	const unsigned long size =3D tbl->it_indirect_levels ?
> @@ -155,8 +157,10 @@ long pnv_npu_set_window(struct pnv_ioda_pe *npe, int=
 num,
>  	return 0;
>  }
> =20
> -long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num)
> +static long pnv_npu_unset_window(struct iommu_table_group *table_group, =
int num)
>  {
> +	struct pnv_ioda_pe *npe =3D container_of(table_group, struct pnv_ioda_p=
e,
> +			table_group);
>  	struct pnv_phb *phb =3D npe->phb;
>  	int64_t rc;
> =20
> @@ -198,7 +202,8 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *np=
e)
>  	if (!gpe)
>  		return;
> =20
> -	rc =3D pnv_npu_set_window(npe, 0, gpe->table_group.tables[0]);
> +	rc =3D pnv_npu_set_window(&npe->table_group, 0,
> +			gpe->table_group.tables[0]);
> =20
>  	/*
>  	 * NVLink devices use the same TCE table configuration as
> @@ -223,7 +228,7 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe =
*npe)
>  	if (phb->type !=3D PNV_PHB_NPU_NVLINK || !npe->pdev)
>  		return -EINVAL;
> =20
> -	rc =3D pnv_npu_unset_window(npe, 0);
> +	rc =3D pnv_npu_unset_window(&npe->table_group, 0);
>  	if (rc !=3D OPAL_SUCCESS)
>  		return rc;
> =20
> @@ -276,9 +281,12 @@ void pnv_npu_try_dma_set_bypass(struct pci_dev *gpde=
v, bool bypass)
>  	}
>  }
> =20
> +#ifdef CONFIG_IOMMU_API
>  /* Switch ownership from platform code to external user (e.g. VFIO) */
> -void pnv_npu_take_ownership(struct pnv_ioda_pe *npe)
> +static void pnv_npu_take_ownership(struct iommu_table_group *table_group)
>  {
> +	struct pnv_ioda_pe *npe =3D container_of(table_group, struct pnv_ioda_p=
e,
> +			table_group);
>  	struct pnv_phb *phb =3D npe->phb;
>  	int64_t rc;
> =20
> @@ -289,7 +297,7 @@ void pnv_npu_take_ownership(struct pnv_ioda_pe *npe)
>  	 * if it was enabled at the moment of ownership change.
>  	 */
>  	if (npe->table_group.tables[0]) {
> -		pnv_npu_unset_window(npe, 0);
> +		pnv_npu_unset_window(&npe->table_group, 0);
>  		return;
>  	}
> =20
> @@ -304,6 +312,12 @@ void pnv_npu_take_ownership(struct pnv_ioda_pe *npe)
>  	pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
>  }
> =20
> +static struct iommu_table_group_ops pnv_pci_npu_ops =3D {
> +	.set_window =3D pnv_npu_set_window,
> +	.unset_window =3D pnv_npu_unset_window,
> +	.take_ownership =3D pnv_npu_take_ownership,
> +};
> +
>  struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
>  {
>  	struct pnv_phb *phb =3D npe->phb;
> @@ -314,6 +328,8 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pn=
v_ioda_pe *npe)
>  	if (!gpe || !gpdev)
>  		return NULL;
> =20
> +	npe->table_group.ops =3D &pnv_pci_npu_ops;
> +
>  	list_for_each_entry(npdev, &pbus->devices, bus_list) {
>  		gptmp =3D pnv_pci_get_gpu_dev(npdev);
> =20
> @@ -326,6 +342,7 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pn=
v_ioda_pe *npe)
> =20
>  	return gpe;
>  }
> +#endif /* !CONFIG_IOMMU_API */
> =20
>  /*
>   * NPU2 ATS
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 7caf373..04639ae 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2677,14 +2677,14 @@ static long pnv_pci_ioda2_npu_set_window(struct i=
ommu_table_group *table_group,
>  		return ret;
> =20
>  	if (table_group->tables[num2])
> -		pnv_npu_unset_window(npe, num2);
> +		npe->table_group.ops->unset_window(&npe->table_group, num2);
> =20
> -	ret =3D pnv_npu_set_window(npe, num, tbl);
> +	ret =3D npe->table_group.ops->set_window(&npe->table_group, num, tbl);
>  	if (ret) {
>  		pnv_pci_ioda2_unset_window(table_group, num);
>  		if (table_group->tables[num2])
> -			pnv_npu_set_window(npe, num2,
> -					table_group->tables[num2]);
> +			npe->table_group.ops->set_window(&npe->table_group,
> +					num2, table_group->tables[num2]);
>  	}
> =20
>  	return ret;
> @@ -2704,19 +2704,22 @@ static long pnv_pci_ioda2_npu_unset_window(
>  	if (!npe->table_group.tables[num])
>  		return 0;
> =20
> -	ret =3D pnv_npu_unset_window(npe, num);
> +	ret =3D npe->table_group.ops->unset_window(&npe->table_group, num);
>  	if (ret)
>  		return ret;
> =20
>  	if (table_group->tables[num2])
> -		ret =3D pnv_npu_set_window(npe, num2, table_group->tables[num2]);
> +		ret =3D npe->table_group.ops->set_window(&npe->table_group, num2,
> +				table_group->tables[num2]);
> =20
>  	return ret;
>  }
> =20
>  static void pnv_ioda2_npu_take_ownership(struct iommu_table_group *table=
_group)
>  {
> -	pnv_npu_take_ownership(gpe_table_group_to_npe(table_group));
> +	struct pnv_ioda_pe *npe =3D gpe_table_group_to_npe(table_group);
> +
> +	npe->table_group.ops->take_ownership(&npe->table_group);
>  	pnv_ioda2_take_ownership(table_group);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvyAqoACgkQbDjKyiDZ
s5LWZxAA4QFfg4th/jGCSjO1ZezQc7ADh6A/wz09GLsXJ8M+PlO2h3bY+WMxvi4e
zxGj3DXCc0nZwLVWX66tBPKaqzN2JPA/md3kbLhpFcAnMQhy386hOILBEiIIZVcQ
b3n9OE/KhMhRYvtuXnzZdEHoetNpMlKbdTnqeHGwgU0fOcUfISztijknFg8TkRNI
tybrMU2VHoSFVNdAhdT42P/4vmF4cr79gp2H2bnw144k/LzrneUaKX7lKWxGm0c3
UcPW/NXDab0GxNPUQKxS4xzb7w+aEvcirBPX+i1TCo3sO4IMTMWtO03fwstTIz+l
uaZdTitDO927blxLvqauVbHhyW84PyEbb2t136zbHtIyhaVQr0M1oA+jOowhwKRs
i5Jm4FUSLbkfkLywlckCwxhyPdSkUi7NSYKlildiw93sDwoRxo+705lil4lGClBl
Gzu6pJnwUw5LEp+4DqmhOsHUNHh95eEIkA3IunL1/qexjATCM3AHN05+yBeMsBWu
ofEegJwFHfmGy9NnXTvmz5DozPFXvPblTdoVsEPxyw00goE7R+aA1Dd8GQCqgRH/
dIyGHm6QngD4nT70zRGsmM6j4/xon8bjFXuv9gnZswQVXNP+hwwQmWO1GchxW7nT
TreUpBEsb1P3T0D4NVIfGgSL5okkdCHnrc9okfvrQfWv9mcRbuw=
=Dug5
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
