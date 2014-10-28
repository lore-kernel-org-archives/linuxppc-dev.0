Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D26FE1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 03:05:39 +1100 (AEDT)
Date: Tue, 28 Oct 2014 16:05:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20141028160516.GZ18557@sirena.org.uk>
References: <cover.1414193668.git.nicoleotsuka@gmail.com>
 <1414194502-14052-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sC1KxrFoiW8MuHBc"
In-Reply-To: <1414194502-14052-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Don't bypass settings if cpu-dai is
 Master
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--sC1KxrFoiW8MuHBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 24, 2014 at 04:48:11PM -0700, Nicolin Chen wrote:
> When cpu-dai is the DAI Master (CBM_CFx), it may need some configurations,
> set_sysclk() call for eample, for cpu-dai side in the hw_params(), even if
> the set_bias_level() has already taken care of the codec-dai side.

Applied, thanks.

--sC1KxrFoiW8MuHBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUT768AAoJECTWi3JdVIfQwmUH/3kHoarWO77yk17oVY3U4Aby
R/vlzUFosMqGZBNmEFamsfbBEd5jNq9P5I5eWvOCoP7bw+OL5RU9F3XU2blZVA+d
7Nt28CXcF7ankJs0Qa2h/3tpbbAbFnx3HW/NIS/xVktH8eYrNZMZ0uVILOePBc5B
P9HWZC+k9CqCIxpi3PWzoPt9e5ipjCknDDQhhdcINrIosnK8sG7vUfUASlSk7YrU
ayMFCqFjL6etw0bX5uoVixA0qmLsOG5UZ1wMZaM7IKy4FmaRsfELhAArX2IAASD9
H7TgQtvIiTufcFUqGVnp5XL5VJME9VoL5/P1haidTca/8HfKi8lTalcVkC9hMcg=
=xXnR
-----END PGP SIGNATURE-----

--sC1KxrFoiW8MuHBc--
