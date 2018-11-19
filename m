Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF52C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 00:28:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA1A2080C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 00:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Cww3WxAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA1A2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42yqSK5S80zF3Rk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 11:28:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Cww3WxAT";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42yqPK4NC9zF3Rm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 11:25:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Cww3WxAT"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42yqPK0nFtz9sBk; Mon, 19 Nov 2018 11:25:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1542587141;
 bh=aVtkHHRVMIohvrmPRrKy3B4qTiVavvjWV3Jz++xVUfc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cww3WxAT96Ec6Owse7khlPDnTpy53ym9GmG9jVr0RGPcLfkiRXrssVcEg1amTzRch
 NzSbPW5Cq6sXvRIpcZbHGkL+1z8jrMiaQ91UYdMu7Lf8xndU0haBo8jIR+bCFcRBPW
 ldpSxXTtcuEmxBt+reLzuskB+AX54rFsEBh5sszU=
Date: Mon, 19 Nov 2018 11:20:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 15/22] powerpc/powernv: Reference iommu_table
 while it is linked to a group
Message-ID: <20181119002023.GB4878@umbus>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-16-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20181113082823.2440-16-aik@ozlabs.ru>
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


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:28:16PM +1100, Alexey Kardashevskiy wrote:
> The iommu_table pointer stored in iommu_table_group may get stale
> by accident, this adds referencing and removes a redundant comment
> about this.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 3 ++-
>  arch/powerpc/platforms/powernv/pci-ioda.c     | 4 ----
>  2 files changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc=
/platforms/powernv/pci-ioda-tce.c
> index 7639b21..697449a 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> @@ -368,6 +368,7 @@ void pnv_pci_unlink_table_and_group(struct iommu_tabl=
e *tbl,
>  	found =3D false;
>  	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
>  		if (table_group->tables[i] =3D=3D tbl) {
> +			iommu_tce_table_put(tbl);
>  			table_group->tables[i] =3D NULL;
>  			found =3D true;
>  			break;
> @@ -393,7 +394,7 @@ long pnv_pci_link_table_and_group(int node, int num,
>  	tgl->table_group =3D table_group;
>  	list_add_rcu(&tgl->next, &tbl->it_group_list);
> =20
> -	table_group->tables[num] =3D tbl;
> +	table_group->tables[num] =3D iommu_tce_table_get(tbl);
> =20
>  	return 0;
>  }
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 7f4904a..7caf373 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2716,10 +2716,6 @@ static long pnv_pci_ioda2_npu_unset_window(
> =20
>  static void pnv_ioda2_npu_take_ownership(struct iommu_table_group *table=
_group)
>  {
> -	/*
> -	 * Detach NPU first as pnv_ioda2_take_ownership() will destroy
> -	 * the iommu_table if 32bit DMA is enabled.
> -	 */
>  	pnv_npu_take_ownership(gpe_table_group_to_npe(table_group));
>  	pnv_ioda2_take_ownership(table_group);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvyAccACgkQbDjKyiDZ
s5IVpxAA1SXEVSeIKnLBOYgRXmPUn5QY5sjTW3oqzhOuqR7UcWLrcytN2j9o/SR2
4RGJBObyj/vg34I5og6MVXP3wQjBKdZRbTBQ79+0jopPgXf/yZvnb1QwMT5sKmjQ
11MDZe6KafIzZE1FTsWbhuEDtsnmAmW4NBptI7DG6c8iwoMq0SIBvOcG5X6+otSV
dB3mUYWeR/BPNkn98H6rP/6g1WDX6kO+z8qiUnLzS0ncDWCZl6PW+1urURYDV3sF
PA8B35/GnTNDJTtm5lm/rUdlOk43X1iOIcRM+ZWW76Cu22GqPCWifZ1fIqj70mII
Kb56czskvDIsiMtGMMr+/Zd3u2b7lzj9CMAbTYmYN1/Aj4LZzU3IgGYOpS21mxo+
k6twPCA6fJ/HH87Eqyzm+tWmivsSiFlPDeRxCZEKFNcdZBf3IM26cBSb1VcJ8fiI
W9XTLgRlhxwm+hnQhTnjqQjr6SDnByXqdsj6LCC+XJbjotW4hqLLHcz54JKqNXVf
/zLsytHIgfBCqQpC/dIuq7+pkOKsr8+VJ5OkWQJe8f8vkGo/5WIO1hEGuy05EZ0L
Pd2BJWU9/3TpElXe8oKOWR50f8Jg0/JTilcysxUVi/lDqglLSZVGfMnCHNGAFxes
xLNOeUzUCd/ocTaLU957144w/lCNDJo4v+g4WLUt23u3H2AaScQ=
=K+nv
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
