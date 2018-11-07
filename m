Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6364BC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 05:21:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D240E20862
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 05:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JPmK0Oj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D240E20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qZXJ6J6qzF3Fv
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 16:21:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="JPmK0Oj/";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qZQp1b3yzF3F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 16:16:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="JPmK0Oj/"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42qZQn5x7bz9sDC; Wed,  7 Nov 2018 16:16:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1541567809;
 bh=uR+yfHyUZRxWmIVN753TKt3eUpYfeX7RFkgVQAk3kIo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JPmK0Oj//FSKRoAPg/FbcY55idt6J3DWUvROLxkdNW0jngqtRP+7O6tzRAUBK45dF
 yKPseRUpQ44GYEf68rJHHiyxT6HmHjR1yr6EPjvQkLNFX02nyT0/zZw023OxgNhZxa
 tE4rSznOPgVeGPpJyvBTxsgwe4VKJ0kU887aurVA=
Date: Wed, 7 Nov 2018 16:08:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 2/5] powerpc/powernv/npu: Collect all static
 symbols under one struct
Message-ID: <20181107050808.GH5575@umbus.fritz.box>
References: <20181015093301.1007-1-aik@ozlabs.ru>
 <20181015093301.1007-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline
In-Reply-To: <20181015093301.1007-3-aik@ozlabs.ru>
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


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 08:32:58PM +1100, Alexey Kardashevskiy wrote:
> We are going to add a global list of NPUs in the system which is going
> to be yet another static symbol. Let's reorganise the code and put all
> static symbols into one struct for better tracking what is really needed
> for NPU (this might become a driver data some day).
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I'm not entirely convinced this is worthwhile, but maybe it'll become
clearer with the later patches.  There are some nits though.

> ---
>  arch/powerpc/include/asm/pci.h            |  1 +
>  arch/powerpc/platforms/powernv/npu-dma.c  | 77 ++++++++++++++++++-------=
------
>  arch/powerpc/platforms/powernv/pci-ioda.c |  2 +
>  3 files changed, 47 insertions(+), 33 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pc=
i.h
> index 2af9ded..1a96075 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -129,5 +129,6 @@ extern void pcibios_scan_phb(struct pci_controller *h=
ose);
> =20
>  extern struct pci_dev *pnv_pci_get_gpu_dev(struct pci_dev *npdev);
>  extern struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int in=
dex);
> +extern void pnv_npu2_devices_init(void);
> =20
>  #endif /* __ASM_POWERPC_PCI_H */
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/plat=
forms/powernv/npu-dma.c
> index 13e5153..01402f9 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -22,20 +22,6 @@
>  #include "pci.h"
> =20
>  /*
> - * spinlock to protect initialisation of an npu_context for a particular
> - * mm_struct.
> - */
> -static DEFINE_SPINLOCK(npu_context_lock);
> -
> -/*
> - * When an address shootdown range exceeds this threshold we invalidate =
the
> - * entire TLB on the GPU for the given PID rather than each specific add=
ress in
> - * the range.
> - */
> -static uint64_t atsd_threshold =3D 2 * 1024 * 1024;
> -static struct dentry *atsd_threshold_dentry;
> -
> -/*
>   * Other types of TCE cache invalidation are not functional in the
>   * hardware.
>   */
> @@ -392,6 +378,33 @@ struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct p=
nv_ioda_pe *npe)
>  /*
>   * NPU2 ATS
>   */
> +static struct {
> +	/*
> +	 * spinlock to protect initialisation of an npu_context for
> +	 * a particular mm_struct.
> +	 */
> +	spinlock_t context_lock;
> +
> +	/* Maximum index of npu2 hosts in the system. Always < NV_MAX_NPUS */
> +	int max_index;
> +
> +	/*
> +	 * When an address shootdown range exceeds this threshold we invalidate=
 the
> +	 * entire TLB on the GPU for the given PID rather than each specific ad=
dress in
> +	 * the range.
> +	 */
> +	uint64_t atsd_threshold;
> +	struct dentry *atsd_threshold_dentry;
> +
> +} npu2_devices;

Even as a structu, it should be possible to statically initialize this.

> +
> +void pnv_npu2_devices_init(void)
> +{
> +	memset(&npu2_devices, 0, sizeof(npu2_devices));

The memset() is unnecessary.  The static structure lives in the BSS,
which means it is already initialized to zeroes.

> +	spin_lock_init(&npu2_devices.context_lock);
> +	npu2_devices.atsd_threshold =3D 2 * 1024 * 1024;
> +}
> +
>  static struct npu *npdev_to_npu(struct pci_dev *npdev)
>  {
>  	struct pnv_phb *nphb;
> @@ -404,9 +417,6 @@ static struct npu *npdev_to_npu(struct pci_dev *npdev)
>  /* Maximum number of nvlinks per npu */
>  #define NV_MAX_LINKS 6
> =20
> -/* Maximum index of npu2 hosts in the system. Always < NV_MAX_NPUS */
> -static int max_npu2_index;
> -
>  struct npu_context {
>  	struct mm_struct *mm;
>  	struct pci_dev *npdev[NV_MAX_NPUS][NV_MAX_LINKS];
> @@ -472,7 +482,7 @@ static void mmio_invalidate_pid(struct mmio_atsd_reg =
mmio_atsd_reg[NV_MAX_NPUS],
>  	int i;
>  	unsigned long launch;
> =20
> -	for (i =3D 0; i <=3D max_npu2_index; i++) {
> +	for (i =3D 0; i <=3D npu2_devices.max_index; i++) {
>  		if (mmio_atsd_reg[i].reg < 0)
>  			continue;
> =20
> @@ -503,7 +513,7 @@ static void mmio_invalidate_va(struct mmio_atsd_reg m=
mio_atsd_reg[NV_MAX_NPUS],
>  	int i;
>  	unsigned long launch;
> =20
> -	for (i =3D 0; i <=3D max_npu2_index; i++) {
> +	for (i =3D 0; i <=3D npu2_devices.max_index; i++) {
>  		if (mmio_atsd_reg[i].reg < 0)
>  			continue;
> =20
> @@ -536,7 +546,7 @@ static void mmio_invalidate_wait(
>  	int i, reg;
> =20
>  	/* Wait for all invalidations to complete */
> -	for (i =3D 0; i <=3D max_npu2_index; i++) {
> +	for (i =3D 0; i <=3D npu2_devices.max_index; i++) {
>  		if (mmio_atsd_reg[i].reg < 0)
>  			continue;
> =20
> @@ -559,7 +569,7 @@ static void acquire_atsd_reg(struct npu_context *npu_=
context,
>  	struct npu *npu;
>  	struct pci_dev *npdev;
> =20
> -	for (i =3D 0; i <=3D max_npu2_index; i++) {
> +	for (i =3D 0; i <=3D npu2_devices.max_index; i++) {
>  		mmio_atsd_reg[i].reg =3D -1;
>  		for (j =3D 0; j < NV_MAX_LINKS; j++) {
>  			/*
> @@ -593,7 +603,7 @@ static void release_atsd_reg(struct mmio_atsd_reg mmi=
o_atsd_reg[NV_MAX_NPUS])
>  {
>  	int i;
> =20
> -	for (i =3D 0; i <=3D max_npu2_index; i++) {
> +	for (i =3D 0; i <=3D npu2_devices.max_index; i++) {
>  		/*
>  		 * We can't rely on npu_context->npdev[][] being the same here
>  		 * as when acquire_atsd_reg() was called, hence we use the
> @@ -683,7 +693,7 @@ static void pnv_npu2_mn_invalidate_range(struct mmu_n=
otifier *mn,
>  	struct npu_context *npu_context =3D mn_to_npu_context(mn);
>  	unsigned long address;
> =20
> -	if (end - start > atsd_threshold) {
> +	if (end - start > npu2_devices.atsd_threshold) {
>  		/*
>  		 * Just invalidate the entire PID if the address range is too
>  		 * large.
> @@ -777,12 +787,12 @@ struct npu_context *pnv_npu2_init_context(struct pc=
i_dev *gpdev,
>  	 * We store the npu pci device so we can more easily get at the
>  	 * associated npus.
>  	 */
> -	spin_lock(&npu_context_lock);
> +	spin_lock(&npu2_devices.context_lock);
>  	npu_context =3D mm->context.npu_context;
>  	if (npu_context) {
>  		if (npu_context->release_cb !=3D cb ||
>  			npu_context->priv !=3D priv) {
> -			spin_unlock(&npu_context_lock);
> +			spin_unlock(&npu2_devices.context_lock);
>  			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
>  						PCI_DEVID(gpdev->bus->number,
>  							gpdev->devfn));
> @@ -791,12 +801,12 @@ struct npu_context *pnv_npu2_init_context(struct pc=
i_dev *gpdev,
> =20
>  		WARN_ON(!kref_get_unless_zero(&npu_context->kref));
>  	}
> -	spin_unlock(&npu_context_lock);
> +	spin_unlock(&npu2_devices.context_lock);
> =20
>  	if (!npu_context) {
>  		/*
>  		 * We can set up these fields without holding the
> -		 * npu_context_lock as the npu_context hasn't been returned to
> +		 * npu2_devices.context_lock as the npu_context hasn't been returned to
>  		 * the caller meaning it can't be destroyed. Parallel allocation
>  		 * is protected against by mmap_sem.
>  		 */
> @@ -887,9 +897,9 @@ void pnv_npu2_destroy_context(struct npu_context *npu=
_context,
>  	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], NULL);
>  	opal_npu_destroy_context(nphb->opal_id, npu_context->mm->context.id,
>  				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
> -	spin_lock(&npu_context_lock);
> +	spin_lock(&npu2_devices.context_lock);
>  	removed =3D kref_put(&npu_context->kref, pnv_npu2_release_context);
> -	spin_unlock(&npu_context_lock);
> +	spin_unlock(&npu2_devices.context_lock);
> =20
>  	/*
>  	 * We need to do this outside of pnv_npu2_release_context so that it is
> @@ -958,9 +968,10 @@ int pnv_npu2_init(struct pnv_phb *phb)
>  	static int npu_index;
>  	uint64_t rc =3D 0;
> =20
> -	if (!atsd_threshold_dentry) {
> -		atsd_threshold_dentry =3D debugfs_create_x64("atsd_threshold",
> -				   0600, powerpc_debugfs_root, &atsd_threshold);
> +	if (!npu2_devices.atsd_threshold_dentry) {
> +		npu2_devices.atsd_threshold_dentry =3D debugfs_create_x64(
> +				"atsd_threshold", 0600, powerpc_debugfs_root,
> +				&npu2_devices.atsd_threshold);
>  	}
> =20
>  	phb->npu.nmmu_flush =3D
> @@ -988,7 +999,7 @@ int pnv_npu2_init(struct pnv_phb *phb)
>  	npu_index++;
>  	if (WARN_ON(npu_index >=3D NV_MAX_NPUS))
>  		return -ENOSPC;
> -	max_npu2_index =3D npu_index;
> +	npu2_devices.max_index =3D npu_index;
>  	phb->npu.index =3D npu_index;
> =20
>  	return 0;
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index e37b9cc..0cc81c0 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1279,6 +1279,8 @@ static void pnv_pci_ioda_setup_PEs(void)
>  	struct pci_bus *bus;
>  	struct pci_dev *pdev;
> =20
> +	pnv_npu2_devices_init();
> +
>  	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>  		phb =3D hose->private_data;
>  		if (phb->type =3D=3D PNV_PHB_NPU_NVLINK) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlviczgACgkQbDjKyiDZ
s5KD7xAA1Y1/tXfH5GJUxQPtjpw8BgEXViNIPQ+Cq+dAaHWVeUhFrn0tj6tJs+y4
ARJJF7ElD7YZJ2W8TGlZ3TOvcwGkAw+syRlA4w8AGYaX0Xgsi0OIDu7cnrX8pdKG
J9Y1syFHtrvauoUhYqGRJjwIblI70rgi9gCnC0DRfwE5jZApG7HYOtJDzhc6x7jj
4NuI5CKeY6Q0ScISB7kf1yYr5dOMlCq89qcsc4n52gwsAvyUYOLzKPBcTbuCfD4F
GoczGJ5hfyDbpZkcwPvl18xdkmVOA3A426aEcYPDMyteRY9Lza2O5vYT2nS+QbF1
7BpZL0Jl6Br4KrnwqMRG4JTxL7ib7wfBtLbx958pOhZgI3rCiN4su2M/QQu1wP3t
IKbxAfqHcAk3hC0rQFLkJt/XZ2f9uv8ZTW3ODxQEmDvaIQJC3dXmm0h+qWmYTwHW
7aTXe7ZW04b3MI3WtcXHNA8mVnQaE4jrxkm5itIAKqRtNwo+2uIzYQTUBel1Gj8u
ZGJqngllKLUbR+lWzbz+DZgohTleyBFZWIe3zzyI9qRyKOqhglbG+1cXBq0YUKlR
io8LkbUJXY1+EDyJaxN17mhOYoQuooy4fDDNSjOlHTYeXID4jdyu+eVZvTcrBdqL
BJAzLMNEhySIiRzuGDPHS82zOKgwyX3oJ50lOPeE/SmUCuvo64E=
=lVfJ
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
