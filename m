Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQ9C623yjzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 11:05:38 +1100 (AEDT)
Date: Fri, 17 Feb 2017 23:48:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Joe Perches <joe@perches.com>, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-ID: <20170217234854.spi62waguwd7kpno@sirena.org.uk>
References: <cover.1487314666.git.joe@perches.com>
 <3d93f7226ba34fede99f72ec038098a3d98a139a.1487314667.git.joe@perches.com>
 <20170217202844.GA8215@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7rsewhxpczujpc6x"
In-Reply-To: <20170217202844.GA8215@Asurada-Nvidia>
Subject: Re: [PATCH 35/35] sound/soc: Convert remaining uses of pr_warning to
 pr_warn
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7rsewhxpczujpc6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2017 at 12:28:44PM -0800, Nicolin Chen wrote:
> On Thu, Feb 16, 2017 at 11:11:48PM -0800, Joe Perches wrote:
> > To enable eventual removal of pr_warning
> >=20
> > This makes pr_warn use consistent for sound/soc
> >=20
> > Prior to this patch, there were 5 uses of pr_warning and
> > 10 uses of pr_warn in sound/soc
> >=20
> > Signed-off-by: Joe Perches <joe@perches.com>
>=20
> For imx-audmux.c,

I don't have this patch, perhaps it got caught in a spam filter or
perhaps it got deleted because as ever you're not using subject lines
reflecting the style for the subsystem.

--7rsewhxpczujpc6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlini+YACgkQJNaLcl1U
h9Dp6Qf/eJnCkxvGqbhbZfW3s4xTK/yhKzQw8PcPME2e0j1wYJaFIJHFUc5T01NQ
Ra/D31mtAXb7RHvZo57T4pfLElaW8SFQ3Ttz2qJLDcEHkkvAPyJcgnuzOR3TwKHz
lTSZnfNo7MTLsZl3DbuViRkNrf9P0vU8RjWGR0XTxoF6Av7pMc0DF7RmelLIpMk8
8a9rrMZ9cdFecrs3+vMKqPZFPGeDUx3kk9lI6CSOgssKoZzRccghS3+CxoXYf7Me
zF/MiWnWXi7y4ja5PPQFgHZd6nlOUp/a6KpDsrJn/BQUdnCSpDW7rRstS4BL/nQL
u3GldzCsyQCDUTf5p1MYv/HhEoex7A==
=PBjj
-----END PGP SIGNATURE-----

--7rsewhxpczujpc6x--
