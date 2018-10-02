Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEF3C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 04:50:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76DA820684
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 04:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ayc2xq8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DA820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PRXS2BqrzF3FF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:50:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ayc2xq8a";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PRTf1rQQzF3D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 14:47:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Ayc2xq8a"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42PRTf06HRz9sCq; Tue,  2 Oct 2018 14:47:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538455654;
 bh=NiGWt/R47N54I6N4wSIGDRRsKVLONj2sKSKxgGMVE5c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ayc2xq8a/VeDJQSReeFzUo9erSbaKgxN/JJRgJm6MoOGFQzGAfZ8AktKkHa/Qb+ta
 keV18QXqaEFDpWN9PVs8qH+mNfZvzE+wB01k51wQ4eaKwNl62lEXCdoaloJnCENxWr
 UGT9mC8oveI7uXDLiorTxhSnmX9iQ/rJZWVuPcHA=
Date: Tue, 2 Oct 2018 14:44:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [RFC PATCH kernel] vfio/spapr_tce: Get rid of possible infinite
 loop
Message-ID: <20181002044433.GC1886@umbus.fritz.box>
References: <20181002032231.7494-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <20181002032231.7494-1-aik@ozlabs.ru>
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
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 01:22:31PM +1000, Alexey Kardashevskiy wrote:
> As a part of cleanup, the SPAPR TCE IOMMU subdriver releases preregistered
> memory. If there is a bug in memory release, the loop in
> tce_iommu_release() becomes infinite; this actually happened to me.
>=20
> This makes the loop finite and prints a warning on every failure to make
> the code more bug prone.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

It does improve the current behaviour.  I do suspect, however, that
leaving the failed regions in the list will probably cause another
failure later on.

> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index b1a8ab3..ece0651 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -371,6 +371,7 @@ static void tce_iommu_release(void *iommu_data)
>  {
>  	struct tce_container *container =3D iommu_data;
>  	struct tce_iommu_group *tcegrp;
> +	struct tce_iommu_prereg *tcemem, *tmtmp;
>  	long i;
> =20
>  	while (tce_groups_attached(container)) {
> @@ -393,13 +394,8 @@ static void tce_iommu_release(void *iommu_data)
>  		tce_iommu_free_table(container, tbl);
>  	}
> =20
> -	while (!list_empty(&container->prereg_list)) {
> -		struct tce_iommu_prereg *tcemem;
> -
> -		tcemem =3D list_first_entry(&container->prereg_list,
> -				struct tce_iommu_prereg, next);
> -		WARN_ON_ONCE(tce_iommu_prereg_free(container, tcemem));
> -	}
> +	list_for_each_entry_safe(tcemem, tmtmp, &container->prereg_list, next)
> +		WARN_ON(tce_iommu_prereg_free(container, tcemem));
> =20
>  	tce_iommu_disable(container);
>  	if (container->mm)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluy964ACgkQbDjKyiDZ
s5J8QQ//Rwfy2Fg+5jLjAPv1qaaCVo35lQcUb63ii8uQgQSoK4s40b9BXtnXhWOY
Zm8j2ZS7SFG6T1sWNBooBAkrfaipyyDcYtSlveCeLV8p4YVMtjoF6gP5jWK3M7Wz
IC8qApl3iUIOBoHbECMTC1NDRYPNw+alCI9JoiewlIqbVRdyZI735aiS6bjerN4D
Qq4GKSDn8xztwJODFUK2EFnWqAN5ZTUrJJeQnrFFb7al4Hc+jR7OFi4Igl7j47y2
OyeS/ZmvjeGSoI+FOgEXPAgT6QFZvguBKOICXOMHOqclSMLWOrS6wPU0W5J7MVpe
LTqisnOLksvn99fc+gZaOcbTMnYHHwSsMStuuZw9bPXGTIL4oXXypa73vlaIvR8w
d4wkHx9Gnnzh50b/rsAgJX4zUkL0wpnPc75m96jCvsUV8BjwRhJGfXbkqlZkOUaE
3/TFLELRdWt2fYAVY4Uhc+uR8Bdt8PqNZydGifkYfl5cn+gpclp7v9CEnjhsXDUB
Lr7sLAsKH2hnI6pIKAkAVBfuYCES2TeOokWN/5g4G+fqbte1spA11sWF4a5Hq2h+
8a/ST9xiaaSw4/m3xuCjWO9ySBHz6ke6bGiWd/sJhEgE1+cNBNpA0Xeivtena+me
mllpIYxqct5cCFHdXdTC0WXGk+PXoJWFYtb80RUtqwdzeuuyioo=
=2nya
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
