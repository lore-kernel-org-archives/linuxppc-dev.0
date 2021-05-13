Return-Path: <SRS0=7n8X=KI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD0CC433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 05:24:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F045613D3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 05:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F045613D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fgg7c6cj1z3c2B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 15:24:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.a=rsa-sha256 header.s=201602 header.b=GCRnulqc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=dgibson@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.a=rsa-sha256 header.s=201602 header.b=GCRnulqc; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fgg662CrMz2yXp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2021 15:22:53 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Fgg653Yhlz9sWl; Thu, 13 May 2021 15:22:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1620883373;
 bh=J4k9I4n3CR3C0H3LQG5hxgKnqKlDCFBVodj2HfgEWsY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GCRnulqcNX27PvXULRAe/yJiKGM2J97NWRkT1oe7Y+Z95r3iJPPnzu35P+ZyihZDv
 yT4u8qprfq1pXhqPXzz0eVkMZdnooReTsVH96C0uOyPJHhuekPsrfnUTkrtPwqVuHT
 SQXwVYppGJU8srBL49c3KyhSAQ7Kv5ySuR30wNd4=
Date: Thu, 13 May 2021 15:21:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 4/4] powerpc/pseries: minor enhancements in
 dlpar_memory_remove_by_ic()
Message-ID: <YJy3VmuwZIBdZ68/@yekko>
References: <20210512202809.95363-1-danielhb413@gmail.com>
 <20210512202809.95363-5-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bHEP+XUHHoT9NjaT"
Content-Disposition: inline
In-Reply-To: <20210512202809.95363-5-danielhb413@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--bHEP+XUHHoT9NjaT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 12, 2021 at 05:28:09PM -0300, Daniel Henrique Barboza wrote:
> We don't need the 'lmbs_available' variable to count the valid LMBs and
> to check if we have less than 'lmbs_to_remove'. We must ensure that the
> entire LMB range must be removed, so we can error out immediately if any
> LMB in the range is marked as reserved.
>=20
> Add a couple of comments explaining the reasoning behind the differences
> we have in this function in contrast to what it is done in its sister
> function, dlpar_memory_remove_by_count().
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  .../platforms/pseries/hotplug-memory.c        | 28 +++++++++++++------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/power=
pc/platforms/pseries/hotplug-memory.c
> index 3c7ce5361ce3..ee88c1540fba 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -517,7 +517,6 @@ static int dlpar_memory_remove_by_index(u32 drc_index)
>  static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
>  {
>  	struct drmem_lmb *lmb, *start_lmb, *end_lmb;
> -	int lmbs_available =3D 0;
>  	int rc;
> =20
>  	pr_info("Attempting to hot-remove %u LMB(s) at %x\n",
> @@ -530,18 +529,29 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_re=
move, u32 drc_index)
>  	if (rc)
>  		return -EINVAL;
> =20
> -	/* Validate that there are enough LMBs to satisfy the request */
> +	/*
> +	 * Validate that all LMBs in range are not reserved. Note that it
> +	 * is ok if they are !ASSIGNED since our goal here is to remove the
> +	 * LMB range, regardless of whether some LMBs were already removed
> +	 * by any other reason.
> +	 *
> +	 * This is a contrast to what is done in remove_by_count() where we
> +	 * check for both RESERVED and !ASSIGNED (via lmb_is_removable()),
> +	 * because we want to remove a fixed amount of LMBs in that function.
> +	 */
>  	for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
> -		if (lmb->flags & DRCONF_MEM_RESERVED)
> -			break;
> -
> -		lmbs_available++;
> +		if (lmb->flags & DRCONF_MEM_RESERVED) {
> +			pr_err("Memory at %llx (drc index %x) is reserved\n",
> +				lmb->base_addr, lmb->drc_index);
> +			return -EINVAL;
> +		}
>  	}
> =20
> -	if (lmbs_available < lmbs_to_remove)
> -		return -EINVAL;
> -
>  	for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
> +		/*
> +		 * dlpar_remove_lmb() will error out if the LMB is already
> +		 * !ASSIGNED, but this case is a no-op for us.
> +		 */
>  		if (!(lmb->flags & DRCONF_MEM_ASSIGNED))
>  			continue;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bHEP+XUHHoT9NjaT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCct1YACgkQbDjKyiDZ
s5Ku3Q/7BhET9h5R0LDptpTNC0rNSdE1w5t8VvDE/0XFcyLQevq9Bt1pBd9AmVvH
1tBa1fXfdR15CuBqL3h1jMb/5Qeih7NHc6I+D0GURE9BWzHnfzAEyv2Ws5WoX0Ad
bQPDuwufZhRj6pEpm0B9MNU1ygOllYLKqptmKDpwC2cwTCtc53uMInLs0dHf29M+
f9AI54UmbgBIdIrn+h8sPgsIq5hFoAkoLMKMbkCrGSJFfWAhfbIsQPWEUeXWHjWS
MuRGzauAky6CH8o1XTSsqJAR1Ywu83Q096Ra/uG0434B+xqwqaHhlLr/Odax0x5Y
QTyB8rKHgTuNDeJ3KHpE7ouLuSqwxm1VRiJfXpWwVez9iL2qWd5UGkVopDOuhZzU
DUHaJrZ+htjcQaJvatK3l/6cdhUvCkQZ9CGe+QGf0KzkvJQo32Ros4IaMRd/Keq/
GUbES9FumwGsYPRYQOeGu2h5rEXr7QMrA6Dyp3/sUm3MgdeLJlNFE5E49QWOyekW
J4CgrZxA/6rQky8wv8K+OCp19LFvJ6vLEd5tUkwfxW5aoqiRlqHFy0ZeGqY72Qy4
EzWJibgevwoJwtKMoHsyLvrj0j3LFX+/D5dA2i4BNzLW819xI2X5yBhb0sB2sMvy
mHMv0ttKc2KqrfLILSx9UdC5y1vhGfgYdNb0sxUprnGVCQ9T6ZA=
=zWc/
-----END PGP SIGNATURE-----

--bHEP+XUHHoT9NjaT--
