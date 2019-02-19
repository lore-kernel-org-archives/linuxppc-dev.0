Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0C7C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 00:58:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0223B217F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 00:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dDNEDGVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0223B217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443Mmd6S5vzDqHH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 11:58:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443Mkf5yMPzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 11:56:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="dDNEDGVN"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 443Mkf4DYFz9rxp; Tue, 19 Feb 2019 11:56:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1550537802;
 bh=Yid3ZyRs46LPJhNsTmFh3/L/MsSHOb6iUgD7KjBtDJc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dDNEDGVNQ+vgqS0B9ILvt8tWXFnkmKEvIzUBNG1AaFv+lN/vf6yzrFnx5fV4m1r1S
 F5Kvpk1itTFLWufJnq3rFuaLMsLSC9teg3QwQMfUVNZk+v53BoS3BnBi6IaYmqePHc
 Kqm87eaen7IWzS4RwfDDnIUKW3dXlJFY/hzIl+6A=
Date: Tue, 19 Feb 2019 11:47:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/powernv/sriov: Register IOMMU groups for
 VFs
Message-ID: <20190219004740.GF9345@umbus.fritz.box>
References: <20190218055801.35165-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <20190218055801.35165-1-aik@ozlabs.ru>
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 04:58:01PM +1100, Alexey Kardashevskiy wrote:
> The compound IOMMU group rework moved iommu_register_group() together in
> pnv_pci_ioda_setup_iommu_api() (which is a part of ppc_md.pcibios_fixup).
> As the result, pnv_ioda_setup_bus_iommu_group() does not create groups
> any more, it only adds devices to groups.
>=20
> This works fine for boot time devices. However IOMMU groups for SRIOV's
> VFs were added by pnv_ioda_setup_bus_iommu_group() so this got broken:
> pnv_tce_iommu_bus_notifier() expects a group to be registered for VF
> and it is not.
>=20
> This adds missing group registration and adds a NULL pointer check into
> the bus notifier so we won't stop in xmon if there is no group, although
> it is not expected to happen now.
>=20
> Fixes: 0bd971676e68 "powerpc/powernv/npu: Add compound IOMMU groups"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> Fixes https://bugzilla.linux.ibm.com/show_bug.cgi?id=3D175550
> "Kernel Oops while creating SRIOV VF's."
>=20
>=20
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 2 ++
>  arch/powerpc/platforms/powernv/pci.c      | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 7db3119..145373f 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1593,6 +1593,8 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pd=
ev, u16 num_vfs)
> =20
>  		pnv_pci_ioda2_setup_dma_pe(phb, pe);
>  #ifdef CONFIG_IOMMU_API
> +		iommu_register_group(&pe->table_group,
> +				pe->phb->hose->global_number, pe->pe_number);
>  		pnv_ioda_setup_bus_iommu_group(pe, &pe->table_group, NULL);
>  #endif
>  	}
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index 45fb70b..ef9448a 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -1147,6 +1147,8 @@ static int pnv_tce_iommu_bus_notifier(struct notifi=
er_block *nb,
>  			return 0;
> =20
>  		pe =3D &phb->ioda.pe_array[pdn->pe_number];
> +		if (!pe->table_group.group)
> +			return 0;
>  		iommu_add_device(&pe->table_group, dev);
>  		return 0;
>  	case BUS_NOTIFY_DEL_DEVICE:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrUisACgkQbDjKyiDZ
s5IJNA/+KGM8WKnBE8zKaOZCWK+YFXfjmX1jG5it++yCzC4PhKXy/kRCMawhEqa1
WfJtLeyODxfPFs9m7kx01vFxme8a5yvoHf98lviwY9wHFGHAiPukZgdUTS10FKK0
mJZibaYwvCwzHvcw3H9oxlX8ue5ySwjDbnRRMVv1j1G6gfI5bUhR1U5tMqvAAUav
6S+mL4of2w/VToDUbK0Hn9ms7Gdchg+gMSNoC17MIHPsjpiKuEg0j2KHdWTUADpq
jIVUYtj2ACR7KyKo4Z0+KjjKyaHRvWwO5VhsoSRE5NyI8r22Ma65jC43muEog55m
U1Vlpaf/f+87c94MXbZH1gAIZXBcfuTzH6M79fiLYS8V6ZpNmonmGp6p6IGBcoC5
rDuMb1c1tRVunqGWmnwV4XcdQiDaaOsR65VHLzA2TxyDHGn0/TuFjPS/56NYOYvj
EiAiMNXnqCWhqlxsP4+2H7Cts8N9Y5x6I4VguCQ2J91fEbo62hpdsqOPGnOpwlq1
j++uVc8uCwnp84xEjockfFlhoNu50dcFtAQ2FJfaGEMHwaNZMt6DRatdiy35jG06
hdNgmT5YUkKtstVV0r/oteMiyO6ARiGBDa9UvMP+VogCv1sCnz7EtkgfuGu4ICLS
lQkjnGoz1kvk3E7PrSjXg57lOT5yQufeFy1qcO0bhHqVUu2GKJ8=
=dD/Q
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
