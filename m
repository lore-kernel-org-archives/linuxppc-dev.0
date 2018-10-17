Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E97C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 02:31:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C09214DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 02:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KYthZd8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C09214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Zbm21d5rzF3L4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 13:31:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KYthZd8t";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Zbbz2JFLzF3Wn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 13:24:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="KYthZd8t"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Zbbz0tzGz9s9J; Wed, 17 Oct 2018 13:24:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1539743087;
 bh=SmaUEuRXe+SvUQitWY6brRs4qqcl7qiL4z8R+qfxb3s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KYthZd8t/ksW3bS2hFYsLmPQXlOWEBpKanIOMqGYX5gyFMSv+KGo8sq0FCzUCQmcZ
 oAPgx7H8HWmvtm+rvO3DisADBkTUPraIiSdG8HdviHvGq1lODOnO8D+Vb9f1lNfHkv
 JuEvc9Pziez2ASNvrmBhuyY36Y+HXJZB+ZAkVJRQ=
Date: Wed, 17 Oct 2018 12:00:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 3/4] powerpc/mm/iommu: Make mm_iommu_new() fail on
 existing regions
Message-ID: <20181017010022.GA30180@umbus.fritz.box>
References: <20181015092416.47380-1-aik@ozlabs.ru>
 <20181015092416.47380-4-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20181015092416.47380-4-aik@ozlabs.ru>
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


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 08:24:15PM +1100, Alexey Kardashevskiy wrote:
> Since we are going to have 2 different preregistering helpers, let's
> make it clear that mm_iommu_new() is only for the normal (i.e. not device)
> memory and for existing areas mm_iommu_get() should be used instead.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I think the idea is sensible.  However (and, yes, this is really an
existing bug) - shouldn't we check for a request to add anything
overlapping with an existing region, not just one that exactly
matches?

> ---
>  arch/powerpc/mm/mmu_context_iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_co=
ntext_iommu.c
> index a8c4a3c..839dbce 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -141,8 +141,7 @@ long mm_iommu_new(struct mm_struct *mm, unsigned long=
 ua, unsigned long entries,
>  	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
>  			next) {
>  		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries)) {
> -			++mem->used;
> -			*pmem =3D mem;
> +			ret =3D -EBUSY;
>  			goto unlock_exit;
>  		}
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvGiaMACgkQbDjKyiDZ
s5JvfQ/+LEQKVnn8B00qbQFQrA4Fa5sIUZAp62MiKBDZwCYI/7oHTzuXiRTSIjUU
I0RCObY5WYw3cFbIcTSHKgWSsjG6zBHPVvlVt8/WVSF4ZVeYhpOa5sU/7n8Pcnme
65LcXyIdDwS2fZHx5gwL3Yx8JqoCMhvqInRLVCEEvJlk8OzebcKSN21bRm/bWz3q
fZhiVZxh/RCfVp0lH9ItaBPCgOMbdLztDTVTSFBDNcOPOv371kBIc4CsFWtdx7kf
yMt637mMilkYOZvn10vNcSSGPYuoV4JZuIzHDcLoieuyN1yZL0EhePynR435p0T8
rEAztrZ2cYargLtC6A43FK6cw8OdPKzvhntg5iB0ID1QYPE8TuW+AwZBkXfZovhz
VtCzeHZv8csw+l1omU8uLdcA5utaJmKer05Mc2g85UcEJ/GtUNr6HpDnta0kdPFu
PT/IauK1p48PhR2sSlz3wdIOyGAl5nMIgSwd91Wy1hqDpHqH9nGC/kWA8hpkCI04
y+OxZOFIxHp7X8TSSuXx5uzDhC6h1fPs9v8SiAg/oKacrPbfYOAUQcjbNXLhOf+T
h4tZHNtq22OvVifQCvRpnOV+ZICFwmvYcq8HUxWWbHXoUaphFdODS0n2RpzXcqkB
WuGO2NvUGhgpu1/QGHeGTej11oqlYrahJHZAQHLFpILZ6W1Bx5w=
=6K1M
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
