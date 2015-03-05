Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B38771A0001
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 23:23:58 +1100 (AEDT)
Date: Thu, 5 Mar 2015 12:23:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20150305122338.GM21293@sirena.org.uk>
References: <1425531904-3770-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LG78JIahM5DeOoET"
In-Reply-To: <1425531904-3770-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Don't try to round-up for PM divisor
 calculation
Cc: alsa-devel@alsa-project.org, timur@tabi.org, tiwai@suse.de,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LG78JIahM5DeOoET
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2015 at 09:05:04PM -0800, Nicolin Chen wrote:
> According to i.MX6 Series Reference Manual, the formula to calculate
> the sys clock is

Applied, thanks.

--LG78JIahM5DeOoET
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+ErKAAoJECTWi3JdVIfQb2MH/2l6/eoNVtJN6skqHfypyrDc
bKAlhWBDGZayYBi7fH7xWLNXGKaLf8PHXqCHzB1qKojSx7HRizsPHY5d6kDB9Cp1
fWZSfeYrlZxQZHanss2FBfJB3MVQcOAGMT3finWFFivKK7WIqfSY78eEN3/O4/Eo
GK69RNthkUT1EXHOdJu8qEfn3pXB37Yyt0mACi35cHRDDOM28wDvZv6G+/hNWxHX
Rkn5Qh/lQ1et8Cw49NPeMSolfL1c7ZioXqq95C1S5JLTEkOic6h2V1YKZUA6lHbn
ZtaNZ44Ismg6iA9vd5KZbUH96oPwApArVQJ1gy1kyPwZaXkm3tfbpcd9zHX4+gA=
=4jJP
-----END PGP SIGNATURE-----

--LG78JIahM5DeOoET--
