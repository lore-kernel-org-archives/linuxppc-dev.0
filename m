Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B355C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:18:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0165B20651
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0165B20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fnpP5r8nzDqZ2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:18:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.15.18; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fnmT6crhzDqY7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 00:16:57 +1100 (AEDT)
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhAVV-1gwllR2jyb-00MO6N; Wed, 16
 Jan 2019 14:16:40 +0100
Date: Wed, 16 Jan 2019 14:16:37 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for STRICT_KERNEL_RWX
Message-ID: <20190116131637.GF22334@latitude>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
 <20190113181621.GA22334@latitude>
 <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
 <20190113210227.GB22334@latitude>
 <334b1b02-b652-499c-904e-09e6f7164b8c@c-s.fr>
 <20190115003353.GD22334@latitude>
 <b37e3635-9c69-0cfc-1283-25459b394033@c-s.fr>
 <20190116003535.GE22334@latitude>
 <f434aafc-7e5f-dfa2-4cfa-03119c27463a@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline
In-Reply-To: <f434aafc-7e5f-dfa2-4cfa-03119c27463a@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:fpG6AMWNkQdp2tjrCTsVorVYxqLjUeGTOfvO1EVLuFud+eT92zH
 +ryYU2l50qvRNFVxElXvN6Nf+MnuZOsEObeBshLRl8qv4brQdJDWhM/WxNwK3SX8AZYChWy
 JR1MRyhcwGLV3r6JSvBZfWv5VIIhr1eabdq7v4WzWmASa3au7BeMpha5uiNc4FM+jTKRiC8
 WePrunfkF70BvPmC+zkXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BXedORg982o=:3kMQxHeF0iEcjem1LPBHWC
 tluDmUH/0TarG9abyClSy5YTP/qW67ycpyyc+TQnQ+KBDUZjQA0DM8Xf/QiQO7hH07y2hw4BB
 xOcL8DiaNWt6Z98jNpLHeOgGXR/BvNxltOMF/9D3wdu5MYHu0YXgRzIdsV/8DzZqN4xb7zgyD
 sVlFYvjRafFhdZ1x9Bs6lIZHbAibNj1sZzdCPz97djeDzhbmBKOKKk30uXFs9wxMvIB/nxxMO
 0QOrqXK+9k3NvclgXoQhYQhvE73ugFpFVzTxSYMq4zKnuGcc0Hc5pxZHP4Ose1q/FvKUAHFB3
 XZhSGr0Yb1iI6xfXgI3mCOCqPNnQlY/FK2seuB0eom8AblLMObCSh1ceygGvgSzKXFleqsFgL
 05inGdLeTj3/7ANgleflQH32h87cp5we7ViuBlAsABDPFEqZbm/geAFDpkCysBtLd6RV3PgQB
 0CgsMofNXieqo07rX74meFmxnYKRHyORkOv3MbLZt8uFzDa5UqoF4htjuM3MqqV3Lm03AXU6E
 mZWA1OF4Tsm3//fOdN4qOw10BYO/I7e9h6NmpWnEpw26cPwwnow9JldmNPvxQj1NPLzmKgB8z
 sjj3FJjncmvRDswzNG/ZblHUvjOwyC/r/hcheGE0/LtOiTmJtX8hm+sZk47EN+wMcW4Z741ce
 KH98/5uJAI38KRKpAw2JOsgmZcW/Sor9R0xmXqi+40V///e/vDUSJ5KZkJvzKucGqaf7n1HeI
 M3O5pp9DLY9ZxlDRjuHLx0KKbiKp73C8fFbuT65sUepmqb8lHjz2xKOdBKCMlX+Cv49GZnsdK
 aYDIBYFraWHJXZTxRqlUp4lZTu0zT4+2XlWzlZkq7VenGVZzq1r2AvuWE/vEUR6gnXzeZ/F5O
 BFbg1vwXppw4H/J4PS90kdU8dESkH77YFQ742lb7bAoFbEDAX2hNbft6Ukft46FTS30mX/kyw
 P4UI2r6+xVA==
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
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 07:55:29AM +0100, Christophe Leroy wrote:
> Le 16/01/2019 =C3=A0 01:35, Jonathan Neusch=C3=A4fer a =C3=A9crit=C2=A0:
> > Thinning the kernel down a bit actually makes it boot again. Ooops...!
> > Maybe enabling CONFIG_STRICT_KERNEL_RWX has made it just large enough to
> > fail the hash table allocation, but there may have been other factors
> > involved (I'm not sure exactly).  Sorry for the confusion!
>=20
> Ok, that must be the reason. Thanks for testing.
>=20
> What about the following modification which maps a second 256Mb BAT, does=
 it
> helps ?
>=20
>=20
>=20
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index c2f564690778..ea574596de37 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -1160,6 +1160,14 @@ initial_bats:
>  	mtspr	SPRN_DBAT0U,r11		/* bit in upper BAT register */
>  	mtspr	SPRN_IBAT0L,r8
>  	mtspr	SPRN_IBAT0U,r11
> +#ifdef CONFIG_WII
> +	addis	r11,r11,0x10000000@h
> +	addis	r8,r8,0x10000000@h
> +	mtspr	SPRN_DBAT2L,r8
> +	mtspr	SPRN_DBAT2U,r11
> +	mtspr	SPRN_IBAT2L,r8
> +	mtspr	SPRN_IBAT2U,r11
> +#endif
>  	isync
>  	blr
>=20
> diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
> index 3f4193201ee7..a334fd5210a8 100644
> --- a/arch/powerpc/mm/ppc_mmu_32.c
> +++ b/arch/powerpc/mm/ppc_mmu_32.c
> @@ -259,6 +259,8 @@ void setup_initial_memory_limit(phys_addr_t
> first_memblock_base,
>  	/* 601 can only access 16MB at the moment */
>  	if (PVR_VER(mfspr(SPRN_PVR)) =3D=3D 1)
>  		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01000000)=
);
> +	else if (IS_ENABLED(CONFIG_WII))
> +		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x20000000)=
);
>  	else /* Anything else has 256M mapped */
>  		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x10000000)=
);
>  }

I haven't tested it, but this patch won't be enough, because we're only
looking at the first memblock, and the additional memory in the Wii
(MEM2) is the second memblock.


Jonathan

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlw/LqwACgkQCDBEmo7z
X9tVhQ/+K0qBCdq2jx8ptrEmd9ekgPcZH7I9etDfa9QBmeHTqxy3nBA+e3opOgCo
ulvADJFZpUByjsfQgFap1TRdM+2l9wNaBuNHSm6A4dSlB7oaIYHyFxLGWFCItgTY
gBcCJvl2HbN/orFfrWqAGBB19AUQrjh6zGZfTP2My/n2ga6TrbwoZuyqhqt6DGpc
cWmKzIdNX4PUfedG9+TDK+2SlZHpfp1GrP5EIWuwPEQxg5IgwqEfTKtSdh6OdWkE
IdDT/mWxYIJWVgCSGSbliU8aJTCbqU7lZwLIJYie05Zrc6r6yZkzEw0IVBHg5nwe
h1EM0KlaNzrcKORammbczZPFhcrwt5XoZKqQtupdPlb1iB2BZqcEPuBqXkbJHv23
98FzRq9Vmr96Tvvnp/3fmGhSV7PFRbVoL673zaLyQ4q+CvNfsTMHH1Me6zos/E/V
HioulcBSJUKQf6xBAjuk6WdcP68cu2/Hsn82WEDoJSGn7t6MEtdyU9w0cI9PxUAE
3oL2xpm/IlyK+Aiw/9FT5dom9ZEmriyCvtVxB5/Ds4xu6xSyKhmroK1Huyp5+XQ3
wdGw24Vf8qKrowz0G8TGx8A7UUUR9ndpAo9fTRuySiwU5eylrwQ3oasNG1ovST+C
YcXzooVUrllHLBx9psbZaicJir9wfPMDWqz9rqj1vrT54X37Y9k=
=bYLA
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
