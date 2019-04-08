Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E285C282CE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 04:30:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D216C20880
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 04:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="B95zOqCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D216C20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44cyCQ5vm9zDqHW
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 14:30:42 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44cy9g6rZxzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 14:29:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="B95zOqCL"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44cy9g4Sghz9sSJ; Mon,  8 Apr 2019 14:29:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1554697751;
 bh=IF21NhypkPiIlJHlk52OaCb5I+V/cXTATPefapCc5jI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B95zOqCL7YAXpgnQ+UoB/hqUH4QUc3CrHUnOOfdki32Nu5GmHyHzLayy3EYIjk4cE
 UYovEsYD/f1HFYsjKCPQMZLA4JwaQo50dKYVhsFuee/xohklUQ1FEA5WgKlILziRvj
 OXiBRnquXkfn4O9rI2dkZfaInzrwjPcDu4c/2sbc=
Date: Mon, 8 Apr 2019 13:58:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/mm_iommu: Allow pinning large regions
Message-ID: <20190408035842.GG16627@umbus.fritz.box>
References: <20190402043101.51229-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Content-Disposition: inline
In-Reply-To: <20190402043101.51229-1-aik@ozlabs.ru>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 03:31:01PM +1100, Alexey Kardashevskiy wrote:
> When called with vmas_arg=3D=3DNULL, get_user_pages_longterm() allocates
> an array of nr_pages*8 which can easily get greater that the max order,
> for example, registering memory for a 256GB guest does this and fails
> in __alloc_pages_nodemask().
>=20
> This adds a loop over chunks of entries to fit the max order limit.
>=20
> Fixes: 678e174c4c16 ("powerpc/mm/iommu: allow migration of cma allocated =
pages during mm_iommu_do_alloc", 2019-03-05)
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/mm/mmu_context_iommu.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index 36a826e23d45..e058064b013c 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -131,6 +131,7 @@ long mm_iommu_new(struct mm_struct *mm, unsigned long=
 ua, unsigned long entries,
>  	unsigned int pageshift, mem_pageshift;
>  	struct page **hpages;
>  	phys_addr_t *hpas;
> +	unsigned long entry, chunk, pinned;
> =20
>  	mutex_lock(&mem_list_mutex);
>  	if (mm_iommu_find(mm, ua, entries)) {
> @@ -152,13 +153,29 @@ long mm_iommu_new(struct mm_struct *mm, unsigned lo=
ng ua, unsigned long entries,
>  	}
> =20
>  	down_read(&mm->mmap_sem);
> -	ret =3D get_user_pages_longterm(ua, entries, FOLL_WRITE, hpages, NULL);
> +	chunk =3D (1UL << (PAGE_SHIFT + MAX_ORDER - 1)) /
> +		sizeof(struct vm_area_struct *);
> +	chunk =3D min(chunk, entries);

I think this is redundant with..

> +	for (entry =3D 0, pinned =3D 0; entry < entries; entry +=3D chunk) {
> +		unsigned long n =3D min(entries - entry, chunk);

=2E. this.

But otherwise LGTM.

> +
> +		ret =3D get_user_pages_longterm(ua + (entry << PAGE_SHIFT), n,
> +				FOLL_WRITE, hpages + entry, NULL);
> +		if (ret =3D=3D n) {
> +			pinned +=3D n;
> +			continue;
> +		}
> +		if (ret >=3D 0)
> +			pinned +=3D ret;
> +		break;
> +	}
>  	up_read(&mm->mmap_sem);
> -	if (ret !=3D entries) {
> +	if (pinned !=3D entries) {
>  		/* free the reference taken */
> -		for (i =3D 0; i < ret; i++)
> +		for (i =3D 0; i < pinned; i++)
>  			put_page(hpages[i]);
> -		ret =3D -EFAULT;
> +		if (!ret)
> +			ret =3D -EFAULT;
>  		goto cleanup_exit;
>  	}
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyqxvIACgkQbDjKyiDZ
s5KRCxAAklKBBaezNpp7myE85y/UjHwTb9ldeKPm8H9SFouEfbBcjkIaLcMMbVOT
smztEouncfggRhlTojcCjvw85PWR4wFnVt9CZfMv4Vae3TQoh4Bmg/df6mjiiTaE
LvSm94yTfGfJEJJEInBivGByw2TScfRtv3p3xCGliloOFViIABWi3EvTHEdQexXP
4J6lCDsVSMrRmUYa43erLGayTXXDHNH+d38CMUmqws6CatCfHDSESJnLYMUO9M9C
FUWV1+8TluFY7MOSuEBG6boTRBclu/xD6wR0kb9yX9ugvz6NdDiEQ+rOPlSzaRk6
3y9EKqtdiwhHRdDPvLXq2aNur+v4XwDBonUQZxCSf7FHgxYn+iOU0ShlvuA59gBE
V8frO4dx39+SdAyJj/Jn97wDPfX25gKx381VVjVXtASJyT0FvMsqjS4B8LwedN7e
U7HXWjLU9IfE7rD5JZ2qVWZCydJV8bNyZmIut4ITH7ERyJ7MvXgzRh90QfPj9XdI
fBZEgJ5aHijqc/kRSlF+uEocrxrE/ritGwloWYdyR6PzBRgdvSlRNUb4NFFHEYas
m8x95ZoSNnGGcVmTSndPeP4UkTUTbN5GlWnif/t4lw8uiaFLpwtKZ+SGpbJKaIGA
oyDg0C/nfzVb6y1xuB8HniPDnkHVV/KlB2v4bTn3UVX1G4SoeNE=
=TOIe
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--
