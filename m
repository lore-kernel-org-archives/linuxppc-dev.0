Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03507C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 05:23:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5482C20862
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 05:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZGs6LEkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5482C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qZZm1l8JzF3Gv
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 16:23:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZGs6LEkz";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qZQp18BNzF3Ds
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 16:16:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="ZGs6LEkz"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42qZQn4tmrz9s7h; Wed,  7 Nov 2018 16:16:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1541567809;
 bh=eSFVVKKscRXTDW4C8ndgIyL8G9SCLZR8pnWpoG/fGIk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZGs6LEkzVUGTNsmLhAr28PvZdjyKwvUUfnHEYEdEo7BQTVATkKL9dQbSUFlkIhtq+
 6A/gpuDmamu8/Yc1tZlL2XXXFTmGVuvZG86c68vQ/EF60CNitGtM4RGiLQkVAj4H1a
 rlWB4w2KTcBW40jGwoChH80Y6ghaubwlIOGPYV7o=
Date: Wed, 7 Nov 2018 16:14:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 3/5] powerpc/powernv: Detach npu struct from pnv_phb
Message-ID: <20181107051444.GI5575@umbus.fritz.box>
References: <20181015093301.1007-1-aik@ozlabs.ru>
 <20181015093301.1007-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Content-Disposition: inline
In-Reply-To: <20181015093301.1007-4-aik@ozlabs.ru>
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


--cVp8NMj01v+Em8Se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 08:32:59PM +1100, Alexey Kardashevskiy wrote:
> The powernv PCI code stores NPU data in the pnv_phb struct. The latter
> is referenced by pci_controller::private_data. We are going to have NPU2
> support in the pseries platform as well but it does not store any
> private_data in in the pci_controller struct; and even if it did,
> it would be a different data structure.
>=20
> This adds a global list of NPUs so each platform can register and use
> these in the same fashion.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci.h     | 16 -------
>  arch/powerpc/platforms/powernv/npu-dma.c | 71 +++++++++++++++++++++++++-=
------
>  2 files changed, 57 insertions(+), 30 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 8b37b28..3b7617d 100644
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
> @@ -180,19 +177,6 @@ struct pnv_phb {
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
> index 01402f9..cb2b4f9 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -378,6 +378,25 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct p=
nv_ioda_pe *npe)
>  /*
>   * NPU2 ATS
>   */
> +/* Maximum possible number of ATSD MMIO registers per NPU */
> +#define NV_NMMU_ATSD_REGS 8
> +
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
> +
> +	struct list_head next;
> +
> +	struct pci_controller *hose;
> +};
> +
>  static struct {
>  	/*
>  	 * spinlock to protect initialisation of an npu_context for
> @@ -396,22 +415,27 @@ static struct {
>  	uint64_t atsd_threshold;
>  	struct dentry *atsd_threshold_dentry;
> =20
> +	struct list_head npu_list;
>  } npu2_devices;
> =20
>  void pnv_npu2_devices_init(void)
>  {
>  	memset(&npu2_devices, 0, sizeof(npu2_devices));
> +	INIT_LIST_HEAD(&npu2_devices.npu_list);
>  	spin_lock_init(&npu2_devices.context_lock);
>  	npu2_devices.atsd_threshold =3D 2 * 1024 * 1024;
>  }
> =20
>  static struct npu *npdev_to_npu(struct pci_dev *npdev)
>  {
> -	struct pnv_phb *nphb;
> +	struct pci_controller *hose =3D pci_bus_to_host(npdev->bus);
> +	struct npu *npu;
> =20
> -	nphb =3D pci_bus_to_host(npdev->bus)->private_data;
> +	list_for_each_entry(npu, &npu2_devices.npu_list, next)
> +		if (hose =3D=3D npu->hose)
> +			return npu;
> =20
> -	return &nphb->npu;
> +	return NULL;

If you're introducing the possibility this can fail, should you also
be introducing checks for NULL in the callers?

>  }
> =20
>  /* Maximum number of nvlinks per npu */
> @@ -843,7 +867,7 @@ struct npu_context *pnv_npu2_init_context(struct pci_=
dev *gpdev,
>  	 */
>  	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], npdev);
> =20
> -	if (!nphb->npu.nmmu_flush) {
> +	if (!npu->nmmu_flush) {

Looks like this hunk belongs in the patch which introduced npdev_to_npu().

>  		/*
>  		 * If we're not explicitly flushing ourselves we need to mark
>  		 * the thread for global flushes
> @@ -967,6 +991,13 @@ int pnv_npu2_init(struct pnv_phb *phb)
>  	struct pci_dev *gpdev;
>  	static int npu_index;
>  	uint64_t rc =3D 0;
> +	struct pci_controller *hose =3D phb->hose;
> +	struct npu *npu;
> +	int ret;
> +
> +	npu =3D kzalloc(sizeof(*npu), GFP_KERNEL);
> +	if (!npu)
> +		return -ENOMEM;
> =20
>  	if (!npu2_devices.atsd_threshold_dentry) {
>  		npu2_devices.atsd_threshold_dentry =3D debugfs_create_x64(
> @@ -974,8 +1005,7 @@ int pnv_npu2_init(struct pnv_phb *phb)
>  				&npu2_devices.atsd_threshold);
>  	}
> =20
> -	phb->npu.nmmu_flush =3D
> -		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
> +	npu->nmmu_flush =3D of_property_read_bool(hose->dn, "ibm,nmmu-flush");
>  	for_each_child_of_node(phb->hose->dn, dn) {
>  		gpdev =3D pnv_pci_get_gpu_dev(get_pci_dev(dn));
>  		if (gpdev) {
> @@ -989,18 +1019,31 @@ int pnv_npu2_init(struct pnv_phb *phb)
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
>  	npu2_devices.max_index =3D npu_index;
> -	phb->npu.index =3D npu_index;
> +	npu->index =3D npu_index;
> +	npu->hose =3D hose;
> +
> +	list_add(&npu->next, &npu2_devices.npu_list);
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

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvidMQACgkQbDjKyiDZ
s5IsqxAAzsItPToucQdUMBdtXbzG8eh/5YM853HXzj+6+j+cnYJUO7rHT6TKSo6L
ItfdUMnGchXUGByfKmue/iEJkDS4QTXKavphoTxOJMY+LYlGS7IBqLAd0+D6Ed3m
89n5nUsK/vRPof07EYyRIefzy2AaaaaMD8s2g5SCYo/uugvhbKUOVSKtKMKhAKXk
wPNDf0Fu4BN0EuAOw1uUF/fylpQ0VsnPC3RqCzFRdptV8wAoms3B2SPgof0KT8u4
ESUs8xrJ+dSkrn/2DvbeSuKnMQFQj5j6zQQ5OFEORa6AaKfjMhFvjEyt8zqo6dKi
VPG/Q3O3p88k5B0iq6Zm+qfij3TiePEXA18r0sNaFhCQbjS6jueWyTTTlFgQ+ToN
LoGotu9P5Ibk1vss4TtiaCUGA2RnmMcxYnWLLat5i/qOppslREZnMcQPFGed2C3/
TFHy7cWWYj/dI/CEpL14Lo2fZYe4eQB2Ec3kKFajsIEeP8XwrxQKxNLcdSzjP4K6
YcjDiyZ+UJg8kBBZKYsg/m75hL1CbKhx/y+1yXhpvCQipwtIqWwa47bDK8HZi0TO
1eSQekbvbs89Nhm26WnNBWttoUB8+O7BeELn4cHBqRzVn/t4uahr++kptYg9+9xr
3DEoe1WCZV1+ZzxYSQYhPdLl5Z+isU6d6yXTYF4kpt5PNJh8xUc=
=cv+/
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--
