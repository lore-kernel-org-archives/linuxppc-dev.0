Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7WwN64B7zDqq4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 20:17:40 +1000 (AEST)
Date: Thu, 13 Jul 2017 11:16:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-ID: <20170713101630.odml56qmsvgxqj64@sirena.org.uk>
References: <20170713072351.GA1485@embeddedgus> <s5hlgnsiyg6.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f6ufjioalak4igbi"
In-Reply-To: <s5hlgnsiyg6.wl-tiwai@suse.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_asrc: constify snd_soc_dai_ops
 structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--f6ufjioalak4igbi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 09:32:41AM +0200, Takashi Iwai wrote:

> please stop posting in this style.  It's really annoying to see
> spontaneously popping-up almost same patch for more than two hours
> long.

> If you have a series of the same fix patches, send them as a patch
> set in a shot with a thread.  git-send-email does it right.

> I don't mind a couple of patches posted separately, but this is over
> the limit.

Or at least just collect them up and send them all at one time even if
not as a single thread (you don't want to CC everyone affected by a
single patch in the set on everything, that's harder to avoid when
sending a series via git, but it can be confusing to get one item in a
large patch series without context). =20

--f6ufjioalak4igbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllnSH0ACgkQJNaLcl1U
h9Bf8Qf6AzXqrmxUZfLyUvE72qUb3AwmnIzLONclZSgwG2VD3VTL65vc3ZAehIMr
AWgSWL0laBKJhAiCdQ6ZQ5r3CQmui27gyIHagZ8GXrVSrgw2/lZOzwPkmTGQA/Ya
OSrRnYVmK/ClSkV12NDYS4uvBRGSho275Y7mfI/rdlqYJMBjgI1uzz2HQn8bQ7iM
QKZ8FIXhjH9Qait3bVYL7m6uYHhAOW7opBnVGOH2m+X30AuD6Wec9XU72Q1/pGvA
GYJmGiImxQtRBV+OK0STvQxO4RJ0INfXL1ZT7b8UY8frMMFx9Mu7CpIidWdtP1jO
ZIzvA0T3+aqq/EALntQqjBHBfp9j/Q==
=nlTK
-----END PGP SIGNATURE-----

--f6ufjioalak4igbi--
