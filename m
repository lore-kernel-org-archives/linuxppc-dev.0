Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C1BA1A054F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 17:25:20 +1100 (AEDT)
Date: Wed, 11 Feb 2015 13:46:16 +0800
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20150211054616.GR2593@finisterre.sirena.org.uk>
References: <1423632703-3683-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tV/+6PImfyFtriLg"
In-Reply-To: <1423632703-3683-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix the incorrect limitation of the bit
 clock rate
Cc: alsa-devel@alsa-project.org, scerveau@voxtok.com,
 linuxppc-dev@lists.ozlabs.org, timur@tabi.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--tV/+6PImfyFtriLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 10, 2015 at 09:31:43PM -0800, Nicolin Chen wrote:
> According to i.MX Reference Manual, the bit-clock frequency generated
> by SSI must be never greater than 1/5 of the peripheral clock frequency.

Applied, thanks.

--tV/+6PImfyFtriLg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2uynAAoJECTWi3JdVIfQHZEH/jBxRyu9zzA7Jj8gey9y/UzC
KLbbYSPkBtiuGMR8dy3UtgIRYRTPpYL7JZRllPxhbvVopRm6dly74XpK5yUm5YHn
nQ+gn6y8IKLaIjC1+xu2OghuiFdcgXT4izCXuykMc06IThgg7OApAjFqRY1fOPKg
NPM5s7g+01bhFUI93B6kLXULX6CbSDM9bOjQ8RmaJ9XCPh/WqCTpQ7JmDkxxTu63
zwJrjT6hLhUcvHnvlnxuKyLrBiQzVdFtBY2nP0wpcXiMREydy3tDVhUrgbu42n6k
KM+OzAyYNWRqYEqKTSkQHlQ4n1Fr2e2gNMi56/jUvfVGDjjvMouNI3Pnyrsj7zU=
=rR+k
-----END PGP SIGNATURE-----

--tV/+6PImfyFtriLg--
