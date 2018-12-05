Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1C7C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 05:17:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F91220672
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 05:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HGm5bbMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F91220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438n6S2z7fzDqjQ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 16:17:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HGm5bbMd";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438n395tjczDqVV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 16:14:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="HGm5bbMd"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 438n394RbFz9s9G; Wed,  5 Dec 2018 16:14:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1543986869;
 bh=LOwMoJqmyAM79yRNIhoyDmbuQjbhyVfakijCXC6/rEA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HGm5bbMdi5GrEt7HoghTX+YP5n1iMRJYqCGldeXWkoVsqskmCjhx7F9/HqkG+7OKG
 35yM+g7yr7aiLG0HI6ldPy1pgkbop5aZ0H8AxMAJYrzl8kRjmpOwqfLnRb2PmbhxSy
 Spxb3QjD56Q2AnSCndgfsTgqTJq14Id0VwiYSMbw=
Date: Wed, 5 Dec 2018 16:14:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v4 04/19] powerpc/powernv: Move npu struct from
 pnv_phb to pci_controller
Message-ID: <20181205051424.GB768@umbus.fritz.box>
References: <20181123055304.25116-1-aik@ozlabs.ru>
 <20181123055304.25116-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <20181123055304.25116-5-aik@ozlabs.ru>
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
 Daniel Henrique Barboza <danielhb413@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 04:52:49PM +1100, Alexey Kardashevskiy wrote:
> The powernv PCI code stores NPU data in the pnv_phb struct. The latter
> is referenced by pci_controller::private_data. We are going to have NPU2
> support in the pseries platform as well but it does not store any
> private_data in in the pci_controller struct; and even if it did,
> it would be a different data structure.
>=20
> This makes npu a pointer and stores it one level higher in
> the pci_controller struct.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v4:
> * changed subj from "powerpc/powernv: Detach npu struct from pnv_phb"
> * got rid of global list of npus - store them now in pci_controller
> * got rid of npdev_to_npu() helper
> ---
>  arch/powerpc/include/asm/pci-bridge.h    |  1 +
>  arch/powerpc/platforms/powernv/pci.h     | 16 -----
>  arch/powerpc/platforms/powernv/npu-dma.c | 81 ++++++++++++++++++------
>  3 files changed, 64 insertions(+), 34 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include=
/asm/pci-bridge.h
> index 94d4490..aee4fcc 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -129,6 +129,7 @@ struct pci_controller {
>  #endif	/* CONFIG_PPC64 */
> =20
>  	void *private_data;
> +	struct npu *npu;
>  };
> =20
>  /* These are used for config access before all the PCI probing
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 2131373..f2d50974 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -8,9 +8,6 @@
> =20
>  struct pci_dn;
> =20
> -/* Maximum possible number of ATSD MMIO registers per NPU */
> -#define NV_NMMU_ATSD_REGS 8
> -
>  enum pnv_phb_type {
>  	PNV_PHB_IODA1		=3D 0,
>  	PNV_PHB_IODA2		=3D 1,
> @@ -176,19 +173,6 @@ struct pnv_phb {
>  	unsigned int		diag_data_size;
>  	u8			*diag_data;
> =20
> -	/* Nvlink2 data */
> -	struct npu {
> -		int index;
> -		__be64 *mmio_atsd_regs[NV_NMMU_ATSD_REGS];
> -		unsigned int mmio_atsd_count;
> -
> -		/* Bitmask for MMIO register usage */
> -		unsigned long mmio_atsd_usage;
> -
> -		/* Do we need to explicitly flush the nest mmu? */
> -		bool nmmu_flush;
> -	} npu;
> -
>  	int p2p_target_count;
>  };
> =20
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/plat=
forms/powernv/npu-dma.c
> index 91d488f..7dd5c0e5 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -327,6 +327,25 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct p=
nv_ioda_pe *npe)
>  	return gpe;
>  }
> =20
> +/*
> + * NPU2 ATS
> + */
> +/* Maximum possible number of ATSD MMIO registers per NPU */
> +#define NV_NMMU_ATSD_REGS 8
> +
> +/* An NPU descriptor, valid for POWER9 only */
> +struct npu {
> +	int index;
> +	__be64 *mmio_atsd_regs[NV_NMMU_ATSD_REGS];
> +	unsigned int mmio_atsd_count;
> +
> +	/* Bitmask for MMIO register usage */
> +	unsigned long mmio_atsd_usage;
> +
> +	/* Do we need to explicitly flush the nest mmu? */
> +	bool nmmu_flush;
> +};
> +
>  /* Maximum number of nvlinks per npu */
>  #define NV_MAX_LINKS 6
> =20
> @@ -478,7 +497,6 @@ static void acquire_atsd_reg(struct npu_context *npu_=
context,
>  	int i, j;
>  	struct npu *npu;
>  	struct pci_dev *npdev;
> -	struct pnv_phb *nphb;
> =20
>  	for (i =3D 0; i <=3D max_npu2_index; i++) {
>  		mmio_atsd_reg[i].reg =3D -1;
> @@ -493,8 +511,10 @@ static void acquire_atsd_reg(struct npu_context *npu=
_context,
>  			if (!npdev)
>  				continue;
> =20
> -			nphb =3D pci_bus_to_host(npdev->bus)->private_data;
> -			npu =3D &nphb->npu;
> +			npu =3D pci_bus_to_host(npdev->bus)->npu;
> +			if (!npu)
> +				continue;

This patch changes a bunch of places that used to unconditionally
locate an NPU now have a failure path.

Given that this used to always have an NPU, doesn't that mean that if
the NPU is not present something has already gone wrong, and we should
WARN_ON() or something?

>  			mmio_atsd_reg[i].npu =3D npu;
>  			mmio_atsd_reg[i].reg =3D get_mmio_atsd_reg(npu);
>  			while (mmio_atsd_reg[i].reg < 0) {
> @@ -662,6 +682,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_=
dev *gpdev,
>  	struct pnv_phb *nphb;
>  	struct npu *npu;
>  	struct npu_context *npu_context;
> +	struct pci_controller *hose;
> =20
>  	/*
>  	 * At present we don't support GPUs connected to multiple NPUs and I'm
> @@ -689,8 +710,11 @@ struct npu_context *pnv_npu2_init_context(struct pci=
_dev *gpdev,
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> -	nphb =3D pci_bus_to_host(npdev->bus)->private_data;
> -	npu =3D &nphb->npu;
> +	hose =3D pci_bus_to_host(npdev->bus);
> +	nphb =3D hose->private_data;
> +	npu =3D hose->npu;
> +	if (!npu)
> +		return ERR_PTR(-ENODEV);
> =20
>  	/*
>  	 * Setup the NPU context table for a particular GPU. These need to be
> @@ -764,7 +788,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_=
dev *gpdev,
>  	 */
>  	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], npdev);
> =20
> -	if (!nphb->npu.nmmu_flush) {
> +	if (!npu->nmmu_flush) {
>  		/*
>  		 * If we're not explicitly flushing ourselves we need to mark
>  		 * the thread for global flushes
> @@ -802,6 +826,7 @@ void pnv_npu2_destroy_context(struct npu_context *npu=
_context,
>  	struct pci_dev *npdev =3D pnv_pci_get_npu_dev(gpdev, 0);
>  	struct device_node *nvlink_dn;
>  	u32 nvlink_index;
> +	struct pci_controller *hose;
> =20
>  	if (WARN_ON(!npdev))
>  		return;
> @@ -809,8 +834,11 @@ void pnv_npu2_destroy_context(struct npu_context *np=
u_context,
>  	if (!firmware_has_feature(FW_FEATURE_OPAL))
>  		return;
> =20
> -	nphb =3D pci_bus_to_host(npdev->bus)->private_data;
> -	npu =3D &nphb->npu;
> +	hose =3D pci_bus_to_host(npdev->bus);
> +	nphb =3D hose->private_data;
> +	npu =3D hose->npu;
> +	if (!npu)
> +		return;
>  	nvlink_dn =3D of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
>  	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
>  							&nvlink_index)))
> @@ -888,9 +916,15 @@ int pnv_npu2_init(struct pnv_phb *phb)
>  	struct pci_dev *gpdev;
>  	static int npu_index;
>  	uint64_t rc =3D 0;
> +	struct pci_controller *hose =3D phb->hose;
> +	struct npu *npu;
> +	int ret;
> =20
> -	phb->npu.nmmu_flush =3D
> -		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
> +	npu =3D kzalloc(sizeof(*npu), GFP_KERNEL);
> +	if (!npu)
> +		return -ENOMEM;
> +
> +	npu->nmmu_flush =3D of_property_read_bool(hose->dn, "ibm,nmmu-flush");
>  	for_each_child_of_node(phb->hose->dn, dn) {
>  		gpdev =3D pnv_pci_get_gpu_dev(get_pci_dev(dn));
>  		if (gpdev) {
> @@ -904,18 +938,29 @@ int pnv_npu2_init(struct pnv_phb *phb)
>  		}
>  	}
> =20
> -	for (i =3D 0; !of_property_read_u64_index(phb->hose->dn, "ibm,mmio-atsd=
",
> +	for (i =3D 0; !of_property_read_u64_index(hose->dn, "ibm,mmio-atsd",
>  							i, &mmio_atsd); i++)
> -		phb->npu.mmio_atsd_regs[i] =3D ioremap(mmio_atsd, 32);
> +		npu->mmio_atsd_regs[i] =3D ioremap(mmio_atsd, 32);
> =20
> -	pr_info("NPU%lld: Found %d MMIO ATSD registers", phb->opal_id, i);
> -	phb->npu.mmio_atsd_count =3D i;
> -	phb->npu.mmio_atsd_usage =3D 0;
> +	pr_info("NPU%d: Found %d MMIO ATSD registers", hose->global_number, i);
> +	npu->mmio_atsd_count =3D i;
> +	npu->mmio_atsd_usage =3D 0;
>  	npu_index++;
> -	if (WARN_ON(npu_index >=3D NV_MAX_NPUS))
> -		return -ENOSPC;
> +	if (WARN_ON(npu_index >=3D NV_MAX_NPUS)) {
> +		ret =3D -ENOSPC;
> +		goto fail_exit;
> +	}
>  	max_npu2_index =3D npu_index;
> -	phb->npu.index =3D npu_index;
> +	npu->index =3D npu_index;
> +	hose->npu =3D npu;
> =20
>  	return 0;
> +
> +fail_exit:
> +	for (i =3D 0; i < npu->mmio_atsd_count; ++i)
> +		iounmap(npu->mmio_atsd_regs[i]);
> +
> +	kfree(npu);
> +
> +	return ret;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwHXrAACgkQbDjKyiDZ
s5L/lBAAkZqpyPllPwyCWKU3f73W3qfAI0bLi3m5qqvJS5LwQu1zZ/3W7l87GAxi
wEx5/JjWpEllBansHSvPGGNXzljM3KOqVCJ+V47lEti2FppNIbR+9+xS3NG/mmJ5
JYqDNXBFb6nDhJVstJyk9SoaHplc5BWfy8vfl5kZTLh8pQ6Knmw1Neiac7t45BZ7
UkgbmBVQageN/D+YcnlnVc1pY4BXOW7sX6zMYguek9Jlpt6E9wlG2UrlDKX1FQbx
MOOW9AVRgc2hoWuVfaXR+EvgXKp8QNIWQJ0v/wj69xAm04Ms5XQbpZ6bgIqfmata
oRdme5DSPA7QmCPCAHsQlYVfR+bMdmtD3FUaW8bRQkketRotPkl0GkLyh+GkoTDv
4ogLRk0k3LSvLWvzYvXDLGZRVVAyWWSdBkRCtncqIQKAvjmFFGq6pqE3FmevFHU2
hi9EyuNt4PhO2XY/8sSGunK80QSLzxDkOfeCjli897EIxML5AsTH1eKhCXkbIFzV
dRqg6JMRYsyZlzrmpZngqwsrru4c0Pgg1o2K50lpg8AjUGJmnWCAS8YN3FPbwkq6
EmbhlEK/5ikkRyYPBxrFji8WidoeSE9lg3AxCMng82wvQAsD0KbZO5UL9+IxKbu1
6AsMpSmmmuHIwNG/lStPvFKWWAjhOgPlFW/FLLX9A4skf5j38Zo=
=avgm
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
