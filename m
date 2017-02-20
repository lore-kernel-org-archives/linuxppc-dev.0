Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRtRV2XNZzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 06:07:18 +1100 (AEDT)
Date: Mon, 20 Feb 2017 11:06:12 -0800
From: Mark Brown <broonie@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-ID: <20170220190612.ykyguxtclicy5dxc@sirena.org.uk>
References: <cover.1487314666.git.joe@perches.com>
 <3d93f7226ba34fede99f72ec038098a3d98a139a.1487314667.git.joe@perches.com>
 <20170217202844.GA8215@Asurada-Nvidia>
 <20170217234854.spi62waguwd7kpno@sirena.org.uk>
 <20170217235751.GA4125@Asurada-Nvidia>
 <1487377247.2198.9.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ju3l6r467ztwkroa"
In-Reply-To: <1487377247.2198.9.camel@perches.com>
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


--ju3l6r467ztwkroa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2017 at 04:20:47PM -0800, Joe Perches wrote:

> If or when you apply it, you should
> fix it up to suit.

To repeat, I don't have this patch so someone will need to send it to
me.

> $ git log -1000 --pretty=3Doneline --no-merges sound/soc |=A0\
>   cut -f2- -d" " | cut -f1 -d":" |sort | uniq
> ALSA
> AsoC
> ASoc
> ASoC
> ASOC
> ASoC fix up SND_SOC_WM8985 dependency

*sigh*  Now try counting the frequency of each...

--ju3l6r467ztwkroa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlirPiMACgkQJNaLcl1U
h9B43Qf8CZDZfm6oqfoNeLBKZKeeclz178n92w0podzmWP1T5Nbai/1xWHPu6uBg
/DH/XOF8d4qmKy7/BIXDg0XyreopDCqG+g8WHzol0H7Faf1pzbRaM8faAmagRPCX
/fv0wuG4R+mAoGZw3bd6yQk0VUQWHgZqXX28KwD3OY+47zbPloE9Gq6IBNqb1TFx
aFScg5IYULKs/4MEvanceca3py3H/9mDmXKqpeibUp5X/CKYKsYWqzhyjYKSQMnK
Gjb9hFEPyIspnYPaUs1/Le+pCuYM4RRGwqrhCrcXdKxg8opW9WbrWvK8aGKRqY5G
COGO5JBwn8ibCQ0oUS/zU2SxX24ojw==
=swEe
-----END PGP SIGNATURE-----

--ju3l6r467ztwkroa--
