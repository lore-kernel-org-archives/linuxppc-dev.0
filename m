Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 568A91A0665
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 23:03:06 +1000 (AEST)
Date: Mon, 25 May 2015 12:58:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 fabio.estevam@freescale.com, zidan.wang@freescale.com
Message-ID: <20150525115812.GG21391@sirena.org.uk>
References: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ov6R7U0hl+EAcYoD"
In-Reply-To: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Don't try to round-up for clock divisor
 calculation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ov6R7U0hl+EAcYoD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 24, 2015 at 01:12:41AM -0700, Nicolin Chen wrote:
> As commit 6c8ca30eec7b ("ASoC: fsl_ssi: Don't try to round-up for PM
> divisor calculation") mentioned that there's no more need to use a
> round up work around to get a better divisor since the clk-divider
> driver has been refined a lot.

Applied, thanks.

--ov6R7U0hl+EAcYoD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYw5TAAoJECTWi3JdVIfQ1PsH/1DoaslX7SwxMS299PW1fdPU
dbNxwOQLCyNfrN2UwKfu44I0VlVfiksuHQMtbPZfqI3ioGMwPd+OyAxmyu5oWFc3
yJp1VvXGQPmBvkKyLfkX/EVFcsHwkotIPXq76GvWG7eq9PDXPsGkK5kGOwW2FVe5
skd0wg1NxvoF84Lc6nBb16/ea0EP5ODDX5L6BUZzFVD4XshC02zclBUmDc9vlYuA
aGdy7gHinhq52Cs4B/VMJe9m6iQKcnCoWIUovVbf1mMDRFR+KjuhnsxQIRPpgk4L
MMDmWV0sqdTHkAg0XpRhjAB4Yub0NccpDQv5kOANXbPTfdou8V3XEv6pKIgdJZo=
=qEqZ
-----END PGP SIGNATURE-----

--ov6R7U0hl+EAcYoD--
