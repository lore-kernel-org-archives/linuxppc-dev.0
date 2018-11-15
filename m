Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F1AC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 09:30:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AF42087A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 09:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZYKGEuzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AF42087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wbg92nxLzF3XT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 20:29:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZYKGEuzu";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wbcT6h3VzF3WZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 20:27:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="ZYKGEuzu"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42wbcT1Xnfz9s9G; Thu, 15 Nov 2018 20:27:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1542274057;
 bh=Fqw3GPC1aeDHrxNzoSjV790WGenmSUR/Rdhai6dglEU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZYKGEuzujLwJ4+R9dt742MpNiEyDLIbGPXYNlgVrV68uazmY6DPEdNqy+MY0Oi8yr
 LPUOyi0Cwzrar4kO07wFK/C0wzNBZmt1Ij/Y2RQ/6sN6kR8rNPStOd7AElgWc6FaGb
 cUziL1//F4Uww3sjUtuZCzU8gqhDye6/m2V1w0iE=
Date: Thu, 15 Nov 2018 16:38:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 03/22] powerpc/mm/iommu: Make mm_iommu_new()
 fail on existing regions
Message-ID: <20181115053815.GE2547@umbus.fritz.box>
References: <20181113082823.2440-1-aik@ozlabs.ru>
 <20181113082823.2440-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <20181113082823.2440-4-aik@ozlabs.ru>
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


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:28:04PM +1100, Alexey Kardashevskiy wrote:
> Since we are going to have 2 different preregistering helpers, let's
> make it clear that mm_iommu_new() is only for the normal memory
> (i.e.not device memory) and for existing areas mm_iommu_get() should be
> used instead.
>=20
> This removes the check for exact match as the check for overlap is
> enough now.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

It would make sense to fold this into the previous patch, I think, but
it's not worth doing a respin just for that.

> ---
> Changes:
> v2:
> * remove the exact match check
> ---
>  arch/powerpc/mm/mmu_context_iommu.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index babc6ad..580d89e 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -102,12 +102,6 @@ long mm_iommu_new(struct mm_struct *mm, unsigned lon=
g ua, unsigned long entries,
> =20
>  	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
>  			next) {
> -		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries)) {
> -			++mem->used;
> -			*pmem =3D mem;
> -			goto unlock_exit;
> -		}
> -
>  		/* Overlap? */
>  		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
>  				(ua < (mem->ua +

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvtBkcACgkQbDjKyiDZ
s5J09hAAxEOz5ZSIBbXhQ7DR9isrX64HWXmu4yIjZ1oSyIt7ctks7bsZQ5m7DSDH
+tDy2G3trOTFtqGaUt4bPDJ+VsCx18uWpUZUiV6Z5OclVFyEHYAsYppA+mYmESnM
TnN6LT55FdwoUpkOfF+J5qENPoHNLatM7B4vSFF65jxeDPEeRm+7a4BZ/X8gyFh/
GMmRN5oxkDb26ntgNJEYE/Oqj0kqSTn4/n1/W7LONZfW5EJARuyrRv71EULDKHsF
ZAVHn8FAU8u/CS14Ip9ierIJ31Hh3iUyJNcZnd6qbJsxQ28tJHjePWJoa63y9QIy
zrcaIjNyqhOst/T06QdTNerEkfF1n8QdDgugOdWVXRuoOQInl7lMwzAlnMGFs212
L1kPdT6FlU4jg3r7V4pvuhtF6qjhAKuQ1Y82wij+lbDKcVC0e70wYHO3YeuxTnTB
tGo00nf8I69E3RDeaOGQMcTd/vcQnRKho23/TgtAQGw+G7MK4fu1hFTdVCOva3Ci
QZvmSBVx1lEJOqNeUtW7XDMcoConlvBD5EBSvepZiNsx/zVAekOCWjbGhENfanG7
QnbcKZpfwwbKe5ps1IMHFPCBdEar250G18LfFPTUCV3csA7WZtU+Vfjn4QeWefr3
eao0lAHk9sKRq3dLxZdiKrk2GeSCkN1ixmo8+kI/fo4WnW3vo8k=
=knbN
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
