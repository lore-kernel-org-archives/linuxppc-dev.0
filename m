Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F78C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:07:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9E320878
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oOOkpnSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9E320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PTGN12w9zF3Dy
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 16:07:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oOOkpnSY";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PT7V6J5qzF333
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 16:01:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="oOOkpnSY"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42PT7V4wTWz9sCq; Tue,  2 Oct 2018 16:01:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538460118;
 bh=0c50NSwPjN1NRLKuNSPHcg0jNSV95Q0aoDK1XXfZonU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oOOkpnSY2cgbS2H3zIcjj75oDvg63pBcae09VuySZ6zJYJyyuijXNmjy3Aof/OA7Q
 mOb6L2fT3d2kjY8X3wG7+bMv+nzIvfGZCeUjWo35IJE9q129DJ3IkNr6C+6JEkUPix
 Zf9Lnj+qxWxr9oWb1xdC7UQmyafuT+vtNVpIvDPE=
Date: Tue, 2 Oct 2018 14:56:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda: Allocate indirect TCE
 levels of cached userspace addresses on demand
Message-ID: <20181002045611.GG1886@umbus.fritz.box>
References: <20180928064539.39050-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Content-Disposition: inline
In-Reply-To: <20180928064539.39050-1-aik@ozlabs.ru>
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


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 04:45:39PM +1000, Alexey Kardashevskiy wrote:
> The powernv platform maintains 2 TCE tables for VFIO - a hardware TCE
> table and a table with userspace addresses; the latter is used for
> marking pages dirty when corresponging TCEs are unmapped from
> the hardware table.
>=20
> a68bd1267b72 ("powerpc/powernv/ioda: Allocate indirect TCE levels
> on demand") enabled on-demand allocation of the hardware table,
> however it missed the other table so it has still been fully allocated
> at the boot time. This fixes the issue by allocating a single level,
> just like we do for the hardware table.
>=20
> Fixes: a68bd1267b72 ("powerpc/powernv/ioda: Allocate indirect TCE levels =
on demand")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc=
/platforms/powernv/pci-ioda-tce.c
> index fe96910..7639b21 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> @@ -299,7 +299,7 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 b=
us_offset,
>  	if (alloc_userspace_copy) {
>  		offset =3D 0;
>  		uas =3D pnv_pci_ioda2_table_do_alloc_pages(nid, level_shift,
> -				levels, tce_table_size, &offset,
> +				tmplevels, tce_table_size, &offset,
>  				&total_allocated_uas);
>  		if (!uas)
>  			goto free_tces_exit;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluy+msACgkQbDjKyiDZ
s5LwMw//Vt5pl31GWaIpcNLPkO/qMdoTn3DE5CGtOHd14ZpOsWMzpNWTHB74KIei
oyGStiNX1YeK7K0BwgVSvSXsaSRONvZ7WFRPmNmLnVnV0P2ZT3tBZN69wDK2VKKw
n4IgqNEyoegt/RmlggdpwNQ37N4CRQdvHdvnPSeV7LiUxV0FOIjlWKVuchnvWcxw
UzcZyV3L1Bxx/iO5ug7om5CdNYhttNhvWKVmgIif6N9I5Lhi7UrcgvK5N0gmQ1N7
F7Vs8pv48LlN1qpR76zMqr7nEY6cystzaKUdwM9KrJvboHmuNQ2sRx3Q46T4UBn4
Q/oYpm25Ds37dxoYvEGfKKL6uaD1VOz1x4G5WJosLQQPrsNZYKcr48e7w7Jr6sRF
0EsMk62wSEgWG3WJGtO7UspKWQpg+6GM8LbelIikxil34sqVZZEP9m4XqtzniBpq
IG8cXMIgv+OcXlG8hwGDIpTrg3XkL3CGpMQHKdEIrt87anfpjd3cwf+Be5td3kjt
PiOnhCrRJWGUWmDr7EGELEzOU+fDP3gx+53KDl2NDSpVn+fQmh8ehU9x8aNWyH8P
bSmvCW5oUiTH33gRDSbNPfJjGpFspktyiIfGdlREmFD7H+kPFSNQOvhGdZBIQ/re
SXnAGjRKM1N4cveSWOK5RKLwWZtgEuU7/fJjrFnoRQTegqeZnvc=
=GwZg
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--
