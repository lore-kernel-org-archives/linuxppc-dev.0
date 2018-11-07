Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5277DC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 05:19:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440EB20862
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 05:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="R1w4R5mY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440EB20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qZTZ57lkzF3G5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 16:19:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="R1w4R5mY";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qZQn5GF4zF3DX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 16:16:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="R1w4R5mY"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42qZQn46Rzz9sD4; Wed,  7 Nov 2018 16:16:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1541567809;
 bh=gFziVi4PcPOCq7D2lazf1lLxLrIG7QOqoPhfAIzNLFQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=R1w4R5mYxZhfO3wDKiQbA7qYsdSrrrpXV+LCptPhJuHV6OQm6iHuS61exk5bCAOZg
 +z+UwmemtEs35b5aK1tBi0ITkNolF4tiPKjjUgd3hHt0+4jU3CYhJqHUs7z1Nu6ELq
 4EXvcsWho3ftMsmDa+GjTwoAo0UivpU1aSCW7oBg=
Date: Wed, 7 Nov 2018 16:04:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 1/5] powerpc/powernv/npu: Add helper to access
 struct npu for NPU device
Message-ID: <20181107050422.GG5575@umbus.fritz.box>
References: <20181015093301.1007-1-aik@ozlabs.ru>
 <20181015093301.1007-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline
In-Reply-To: <20181015093301.1007-2-aik@ozlabs.ru>
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
Cc: Alistair Popple <alistair@popple.id.au>,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 08:32:57PM +1100, Alexey Kardashevskiy wrote:
> This step is to help removing the npu struct from pnv_phb so it
> can be used by pseries as well.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/plat=
forms/powernv/npu-dma.c
> index 3a5c4ed..13e5153 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -389,6 +389,18 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct p=
nv_ioda_pe *npe)
>  	return gpe;
>  }
> =20
> +/*
> + * NPU2 ATS
> + */
> +static struct npu *npdev_to_npu(struct pci_dev *npdev)
> +{
> +	struct pnv_phb *nphb;
> +
> +	nphb =3D pci_bus_to_host(npdev->bus)->private_data;
> +
> +	return &nphb->npu;
> +}
> +
>  /* Maximum number of nvlinks per npu */
>  #define NV_MAX_LINKS 6
> =20
> @@ -546,7 +558,6 @@ static void acquire_atsd_reg(struct npu_context *npu_=
context,
>  	int i, j;
>  	struct npu *npu;
>  	struct pci_dev *npdev;
> -	struct pnv_phb *nphb;
> =20
>  	for (i =3D 0; i <=3D max_npu2_index; i++) {
>  		mmio_atsd_reg[i].reg =3D -1;
> @@ -561,8 +572,7 @@ static void acquire_atsd_reg(struct npu_context *npu_=
context,
>  			if (!npdev)
>  				continue;
> =20
> -			nphb =3D pci_bus_to_host(npdev->bus)->private_data;
> -			npu =3D &nphb->npu;
> +			npu =3D npdev_to_npu(npdev);
>  			mmio_atsd_reg[i].npu =3D npu;
>  			mmio_atsd_reg[i].reg =3D get_mmio_atsd_reg(npu);
>  			while (mmio_atsd_reg[i].reg < 0) {
> @@ -749,7 +759,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_=
dev *gpdev,
>  	}
> =20
>  	nphb =3D pci_bus_to_host(npdev->bus)->private_data;
> -	npu =3D &nphb->npu;
> +	npu =3D npdev_to_npu(npdev);
> =20
>  	/*
>  	 * Setup the NPU context table for a particular GPU. These need to be
> @@ -869,7 +879,7 @@ void pnv_npu2_destroy_context(struct npu_context *npu=
_context,
>  		return;
> =20
>  	nphb =3D pci_bus_to_host(npdev->bus)->private_data;
> -	npu =3D &nphb->npu;
> +	npu =3D npdev_to_npu(npdev);
>  	nvlink_dn =3D of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
>  	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
>  							&nvlink_index)))

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlviclQACgkQbDjKyiDZ
s5IjGg//V1t/xCx4mZevE/EYjrggr9ev+Zyt8seTqC9BIVko7uOF/jZJJ0wb+zBH
z4OSAlwRtQ+SZ7Nvhuz0ZqnDbI3sk3T22z39kgiH7cdKmMN9CntabhuWSb9z4QSb
TdDUBgU8qaTENS03xvQytDeeCH/Wtt6paPXNqMS+waDqh7ZGo1qoXqTJHf09m00e
PQgDa4p8HVWLRswVCPRYMWloMg5qXNOz4fd+35o7RNMOdsFvHCKT6oYG9k6mZ1Qj
aGKKOEhVAn/A2+kV4sLb5BvmGV3W2NVa/cEXU8KE8KDoHm0uqf21IJ0ntTqx7e7C
53DXHRORX2QVD+ccQn1hlNX3MI1VV+e6SmHGlsPWNUIyfpUmsHV2SF6nMqQbxNXd
9QuEa38zK1iSvLn+M9z3skBixBIGJkP8w3QUpW93LjLsj9+UnhdRAmHwvoNigCAA
M/bk893jyQwLiZ8a4945Wt0bzoIDH3EJKgxm1/sAJTElC5trgMcTiga2jM7NeKqm
g5HbrI3knJc4/Q5Vrin5cUSDE7ky9oKDsl/QICv3tYTi4mi+bVZosSHVgVHAPP63
zQSIyYx9x9noPebjwuDLHsDEmlUVbiK3I6jgJo+T5v+lBP5iwbQHt28hE9HvWoPD
lqNdSN0QaSA3rESJ7PqS71MvduHqOzaDc2r5aPUec6kmHi+Tna0=
=XWT2
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
