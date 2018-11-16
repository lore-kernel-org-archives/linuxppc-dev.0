Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB65C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 05:02:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB03A208A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 05:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MpgtMk6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB03A208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42x5hM63pbzF3CC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 16:02:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MpgtMk6I";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42x5VW3ChpzF3k2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 15:54:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="MpgtMk6I"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42x5VW1fcbz9sBN; Fri, 16 Nov 2018 15:54:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1542344051;
 bh=DJmsn2+7WDsNGqHlh55m4z0f8vnwOPsABrDKZcOzVko=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MpgtMk6IDmFObsWY2/zKu0W52lA948CgYCLev2bD1+Cx6tBpUQaQh/gjud3o6+uKl
 3iN7g5JXj83mHcWwnjoIONv4H+eZJT817zIg0d5lG0TZycRdiereWXcT9H2AU13eI1
 JJdmeL5lYISrhDsFJlZcGr9YnC4SwXT+pIKT0j7w=
Date: Fri, 16 Nov 2018 15:54:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 09/22] powerpc/pseries/iommu: Force default DMA
 window removal
Message-ID: <20181116045405.GB23632@umbus>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-10-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20181113082823.2440-10-aik@ozlabs.ru>
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


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:28:10PM +1100, Alexey Kardashevskiy wrote:
> It is quite common for a device to support more than 32bit but less than
> 64bit for DMA, for example, GPUs often support 42..50bits. However
> the pseries platform only allows huge DMA window (the one which allows
> the use of more than 2GB of DMA space) for 64bit-capable devices mostly
> because:
>=20
> 1. we may have 32bit and >32bit devices on the same IOMMU domain and
> we cannot place the new big window where the 32bit one is located;
>=20
> 2. the existing hardware only supports the second window at very high
> offset of 1<<59 =3D=3D 0x0800.0000.0000.0000.
>=20
> So in order to allow 33..59bit DMA, we have to remove the default DMA
> window and place a huge one there instead.
>=20
> The PAPR spec says that the platform may decide not to use the default
> window and remove it using DDW RTAS calls. There are few possible ways
> for the platform to decide:
>=20
> 1. look at the device IDs and decide in advance that such and such
> devices are capable of more than 32bit DMA (powernv's sketchy bypass
> does something like this - it drops the default window if all devices
> on the PE are from the same vendor) - this is not great as involves
> guessing because, unlike sketchy bypass, the GPU case involves 2 vendor
> ids and does not scale;
>=20
> 2. advertise 1 available DMA window in the hypervisor via
> ibm,query-pe-dma-window so the pseries platform could take it as a clue
> that if more bits for DMA are needed, it has to remove the default
> window - this is not great as it is implicit clue rather than direct
> instruction;
>=20
> 3. removing the default DMA window at all it not really an option as
> PAPR mandates its presense at the guest boot time;
>=20
> 4. make the hypervisor explicitly tell the guest that the default window
> is better be removed so the guest does not have to think hard and can
> simply do what requested and this is what this patch does.

This approach only makes sense if the hypervisor has better
information as to what to do that the guest does.  It's not clear to
me why that would be the case.  Isn't the DMA capabilities of the
device something the driver should know, in which case it can decide
based on that?

>=20
> This makes use of the latter approach and exploits a new
> "qemu,dma-force-remove-default" flag in a vPHB.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/pseries/iommu.c | 28 +++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platfo=
rms/pseries/iommu.c
> index 9ece42f..78473ac 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -54,6 +54,7 @@
>  #include "pseries.h"
> =20
>  #define DDW_INVALID_OFFSET	((uint64_t)-1)
> +#define DDW_INVALID_LIOBN	((uint32_t)-1)
> =20
>  static struct iommu_table_group *iommu_pseries_alloc_group(int node)
>  {
> @@ -977,7 +978,8 @@ static LIST_HEAD(failed_ddw_pdn_list);
>   *
>   * returns the dma offset for use by dma_set_mask
>   */
> -static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> +static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn,
> +		u32 default_liobn)
>  {
>  	int len, ret;
>  	struct ddw_query_response query;
> @@ -1022,6 +1024,16 @@ static u64 enable_ddw(struct pci_dev *dev, struct =
device_node *pdn)
>  	if (ret)
>  		goto out_failed;
> =20
> +	/*
> +	 * The device tree has a request to force remove the default window,
> +	 * do this.
> +	 */
> +	if (default_liobn !=3D DDW_INVALID_LIOBN && (!ddw_avail[2] ||
> +			rtas_call(ddw_avail[2], 1, 1, NULL, default_liobn))) {
> +		dev_dbg(&dev->dev, "Could not remove window");
> +		goto out_failed;
> +	}
> +
>         /*
>  	 * Query if there is a second window of size to map the
>  	 * whole partition.  Query returns number of windows, largest
> @@ -1212,7 +1224,7 @@ static int dma_set_mask_pSeriesLP(struct device *de=
v, u64 dma_mask)
>  	pdev =3D to_pci_dev(dev);
> =20
>  	/* only attempt to use a new window if 64-bit DMA is requested */
> -	if (!disable_ddw && dma_mask =3D=3D DMA_BIT_MASK(64)) {
> +	if (!disable_ddw && dma_mask > DMA_BIT_MASK(32)) {
>  		dn =3D pci_device_to_OF_node(pdev);
>  		dev_dbg(dev, "node is %pOF\n", dn);
> =20
> @@ -1229,7 +1241,17 @@ static int dma_set_mask_pSeriesLP(struct device *d=
ev, u64 dma_mask)
>  				break;
>  		}
>  		if (pdn && PCI_DN(pdn)) {
> -			dma_offset =3D enable_ddw(pdev, pdn);
> +			u32 liobn =3D DDW_INVALID_LIOBN;
> +			int ret =3D of_device_is_compatible(pdn, "IBM,npu-vphb");
> +
> +			if (ret) {
> +				dma_window =3D of_get_property(pdn,
> +						"ibm,dma-window", NULL);
> +				if (dma_window)
> +					liobn =3D be32_to_cpu(dma_window[0]);
> +			}
> +
> +			dma_offset =3D enable_ddw(pdev, pdn, liobn);
>  			if (dma_offset !=3D DDW_INVALID_OFFSET) {
>  				dev_info(dev, "Using 64-bit direct DMA at offset %llx\n", dma_offset=
);
>  				set_dma_offset(dev, dma_offset);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvuTWoACgkQbDjKyiDZ
s5KNJA//cZ4LytyMDWjjc30ebCGG/lGBWWC5tWFLkCgDSerzCrRlpTyRdUxj4Q92
5foiEgg7ssJEVh8mW2Zwx1mtfEyBo3rpOjnBC0FaGMu2tmk8AisAMZYE2ywqRSZW
l2MseC28+wPir6OpTKhqzGsBAsiSV0sd9DGxD2EmmvCQv1JzW8/Ao9vyk7m0DFQw
dH135rUasNYKettRVs/7MrLjK3MMYlqGCRJa0GUhLp10JA7P9tH9nDhrlNBTQl2g
BAhUwDaNGFYMTFurUPTGEi5SoOCFq0lBAagFDlkqOUrJWFTDvC08RkZ9c9VksJ+u
ULwqZVyaJi4/HGxGcMwyrrtOKHpQcRefUxoqTCMgGnwf9ErEsYubg6P+0QMMpXWf
hyWMXYHzQbLtLums35x9iIzptgG8OUAVu31ZzpQCTWPbhdxyJZUvZVjJdlh6gp6y
os5NAQNrKBkj7ESB0ZDcsm7KH24oYOQbetir6GlieLcGavo//89G1d/pQ2ESeIBC
mz/w3h+if/GTRjW5w+c7VMd46WzzCb+ji8IOeg+1Fo9utzOtt5gKt1ECbxqe7zZI
svcrNPuEIeNyv0ru1QgqUmAsjTaJWrDr8vraQtDvJVwl79kO12m583+Q1S+VpatM
9hRwYwLNgIM+I89UOnsFPEv/ZOcUg5fvfS0IMdvi9pN+doM0s6A=
=XXDc
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
