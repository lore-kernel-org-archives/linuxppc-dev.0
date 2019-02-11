Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47B8C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:54:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132BD20836
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QKtbxrzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132BD20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z5LB1dsmzDqRC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 12:54:10 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z5JK0gvGzDqMF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 12:52:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="QKtbxrzH"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43z5JJ5PP6z9s5c; Tue, 12 Feb 2019 12:52:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549936352;
 bh=SEwp9rGdKMp14lam9p8u7FMTvSGDQxSFn/D0Sfe7UcE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QKtbxrzHwylbWnfzN59QzuAg7/P+wyePGX7+d1VeBTDYGVOQV40oA6SM6+ODAQ7B6
 XAq32onH6pSxuMsz4BM6zSCDArJ58R5eI2L8/e5zQ/K3hY07CRBWsZKln0HPBeZDMl
 NR2r/pmp/dv+mKA3ivH3dqVQJds3fSUm1sgghZvw=
Date: Tue, 12 Feb 2019 10:44:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] vfio/spapr_tce: Skip unsetting already unset table
Message-ID: <20190211234402.GA1884@umbus.fritz.box>
References: <20190211074917.125723-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20190211074917.125723-1-aik@ozlabs.ru>
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
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 06:49:17PM +1100, Alexey Kardashevskiy wrote:
> VFIO TCE IOMMU v2 owns IOMMU tables so when detach a IOMMU group from
> a container, we need to unset those from a group so we call unset_window()
> so do we unconditionally. We also unset tables when removing a DMA window
> via the VFIO_IOMMU_SPAPR_TCE_REMOVE ioctl.
>=20
> The window removal checks if the table actually exists (hidden inside
> tce_iommu_find_table()) but the group detaching does not so the user
> may see duplicating messages:
> pci 0009:03     : [PE# fd] Removing DMA window #0
> pci 0009:03     : [PE# fd] Removing DMA window #1
> pci 0009:03     : [PE# fd] Removing DMA window #0
> pci 0009:03     : [PE# fd] Removing DMA window #1
>=20
> At the moment this is not a problem as the second invocation
> of unset_window() writes zeroes to the HW registers again and exits early
> as there is no table.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> When doing VFIO PCI hot unplug, first we remove the DMA window and
> set container->tables[num] - this is a first couple of messages.
> Then we detach the group and then we see another couple of the same
> messages which confused myself.
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index c424913..8dbb270 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -1235,7 +1235,8 @@ static void tce_iommu_release_ownership_ddw(struct =
tce_container *container,
>  	}
> =20
>  	for (i =3D 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
> -		table_group->ops->unset_window(table_group, i);
> +		if (container->tables[i])
> +			table_group->ops->unset_window(table_group, i);
> =20
>  	table_group->ops->release_ownership(table_group);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiCMIACgkQbDjKyiDZ
s5IxbRAAmN9gMqiO/3VZgJNegka6aYVucNhOGqsm1UKV0JpnZk+hahJfj5WY61fm
DmsgaoMoMqtnE6th4xmEQyezhPSwZPs32JGrVpipct1lcQwMQMV5CboWW/VnPuYz
xWJGTHIxBPJH1Qu/KI0nRH6D7pIEkmVR0fbg4OgJ+dot0ZxUARuEwkExlWVIDKme
QSsEOlAXu1mu9Roo4nabsbgshBDXMGj3x9iG7W3aNM2GWxWoPE7jnznYZT9k3CMC
hSEJVCPyTXu10m94Dbk9rLnAtN0DLR23EoIxUuDcw/9UxZCnD8LiQpN/+W1jLEi/
cTz3ppWcb/jbq3d9ODLXN6bTR16xzNF42F9yo97oCwnKy2MslenmLRvMtq0+EBZO
I0g3jYhSgpt0Y7/Ok+XnBVdRL0pN1PdyCWLVD6p3lGN102J/ZQT1SJQTCisr9UZf
ek2YV1ZXQ043sljrr5zMQA1ODkklx7oD0FnrE602TXS0XB9cKeFVtUsS3bozPxoR
tdx1Gs2I+oa3erBAg4Q1OKP4tEbP/buOZHpMSetuPRXwxRffu9i/q7ezyaoDfpG0
f7kk4jPPUEsT/uCU0eslzsMpqDnNbqiWBHr9rAvwOW92IHg/XYILB/6xrBSbcQ5s
6rh++cgvhXWRjKA/Zm5X+SyeylETEzzSfnlUVz8c+QlxbLm2pSU=
=AsjF
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
