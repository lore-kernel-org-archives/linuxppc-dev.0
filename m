Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 569461A17E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 05:23:26 +1100 (AEDT)
Date: Tue, 12 Jan 2016 18:22:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20160112182253.GD6588@sirena.org.uk>
References: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="82NP6SxOLIStdcnZ"
In-Reply-To: <1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
Subject: Re: [PATCH 1/2] ASoC: fsl: imx-sgtl5000: make audmux optional for
 imx sound driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--82NP6SxOLIStdcnZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2016 at 07:13:30PM +0100, Lothar Wa=DFmann wrote:

> i.MX6UL does not have the audio multiplexer (AUDMUX) like e.g. i.MX6Q,
> but apart from that can use the same audio driver. Make audmux
> optional for the imx-sgtl5000 driver, so it can be used on i.MX6UL
> too. Also i.MX6UL requires use of the SAI interface rather than SSI.

If it doesn't have the audmux can you use simple-card?

--82NP6SxOLIStdcnZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWlUR8AAoJECTWi3JdVIfQ+E4H/3PydkAaOQIjz6jHf+DO6i6/
/n0EgxkwNklvC21OdxfFTcT8jFsrdBVjp4V2c7HQtpQJu+n/xNfs8MPeFzdJ1JjH
ZKufo116krlX1qBwGAm+K5nl89wq6SGl7XQWHW5aoDKY/TwsojzrIA60HwdbM0xR
JnxoaVEzRdXf8qCRcLhCvs18bFymBXeo1MEBPlVycXhEu2KL7nuirxMhtpcrersx
4lyqlpWzeziuhro6WcspK07cOr5gkkJflaQpuBfZCLSg8npfKgr6FTXgAQqVH2KV
48FputkMG8HF4JYEMwRjCFj69juNuzIJYrnbqplAmG+1+E0AzRra6FPR39fP1M8=
=tub5
-----END PGP SIGNATURE-----

--82NP6SxOLIStdcnZ--
