Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 364CA1A03C7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 00:56:47 +1000 (EST)
Date: Mon, 18 Aug 2014 09:54:52 -0500
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Message-ID: <20140818145452.GD14537@sirena.org.uk>
References: <cover.1408350626.git.shengjiu.wang@freescale.com>
 <ee71a6cacc1d0bc1459bf9c21efc755c16e955b1.1408350626.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TMTfqzsZeEKgETVO"
In-Reply-To: <ee71a6cacc1d0bc1459bf9c21efc755c16e955b1.1408350626.git.shengjiu.wang@freescale.com>
Subject: Re: [PATCH V1 3/3] ASoC: fsl: fsl-asoc-card: Select SND_SOC_IMX_AUDMUX
Cc: fabio.estevam@freescale.com, sfr@canb.auug.org.au,
 alsa-devel@alsa-project.org, timur@tabi.org, arnd@arndb.de, shc_work@mail.ru,
 tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com,
 xobs@kosagi.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--TMTfqzsZeEKgETVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2014 at 04:38:40PM +0800, Shengjiu Wang wrote:
> Building kernel with SND_SOC_IMX_AUDMUX=n leads to the following error:

Applied, thanks.

--TMTfqzsZeEKgETVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8hO4AAoJELSic+t+oim9FdAP+gKsNJnyM2axEABYJ1G4HGnG
dQ/Po4rAdZ/C9NVtTgZq66v/YyGetydNLU9mjYAFIzaxgI1Mp1ca+IfNobO+K46W
9Mrx76t6Oc86hsRL4XQoMhCT5rQDHKYLz8aSaGCUm9ScQyyfTvNH7f3gjD6w/o5o
YzPP3hdoZvhvHR6Tcu9RpG0XLc8iKmcEwBJgWY2yHrnRnrWw7SHdkUYNTt3xfvzG
RiAUBpBcPOX9tKQCFiXAX54iNbBRQtq9cgLa9RSZll/Mjd2vMIJGNxGRqSyTYHVH
+LxpxMY422C3/mBh78RbTo+Zypu9teXdstF2YhEKCyZ5wsQeYIFJYhhqDxGWHhGo
7QiiSAvJXP3icmHH2yri+fpsEhZ/tAFm6CEA4Uk/Rg4z2QFBtxs2XypH21fJS7FH
ywddDt8K/fW5MfEa/X8IoHxhkAj0asq6kknFqJJ66F/wsc2xytWQHcRO8nlFQj2e
gWGh2yDvy17IWTtBgbtOgl3Tes8iYz9s7P2eBTR8ttg7Pcydf+AdPCskYW5Py4US
sgzl67Ak9UQvpJuF20TVl19g4Q2w5sD5wci6PDVm5JeCAYN4zcC7fmfG7wOLojbc
sewHkUAIXrfYpaV3ZCARg9RX39UWKFGlLgewliY+cFEe0/f7n7iF8bT9lPi9Igt3
ph+r3vtJi68HvW8cmTKP
=tLCH
-----END PGP SIGNATURE-----

--TMTfqzsZeEKgETVO--
