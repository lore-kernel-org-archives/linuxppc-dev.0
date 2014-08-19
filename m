Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BB821A003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 02:20:01 +1000 (EST)
Date: Tue, 19 Aug 2014 11:12:17 -0500
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Message-ID: <20140819161217.GK24407@sirena.org.uk>
References: <bfed4dfd3cf1ef134dac1f114f3d2b8cedf55c68.1408440952.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
In-Reply-To: <bfed4dfd3cf1ef134dac1f114f3d2b8cedf55c68.1408440952.git.shengjiu.wang@freescale.com>
Subject: Re: [PATCH V2] ASoC: fsl-asoc-card: move 'config
 SND_SOC_FSL_ASOC_CARD' to 'if SND_IMX_SOC'
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


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 19, 2014 at 05:36:41PM +0800, Shengjiu Wang wrote:
> Build kernel with SND_SOC_FSL_ASOC_CARD=m && SND_SOC_FSL_{SSI,SAI,ESAI}=y
> leads the following error:

Applied, thanks.

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT83deAAoJELSic+t+oim9uToP/i3y1fRfHj1rQn0Iv+LEJd91
MjSO6dPrx5Bvb7AOzfSNTYpu2i3vnHiDfb/tu9/316WllJFZPf96rECTqJJAYnT0
63BM1UfkYtSR3nXB1EEa9vpKc2GJbEZthz3ONRiB8UGVmH0RHNhql6ErGig09TgZ
v6EylmP6t18LhL9rFzzZK0CpjaLAKADk59rTCqIYU+tyh3YEtQwAnqBOzsVtCfwU
SemBNPD3SkOoq8zoi1Pc9Ohc2pOgws2BSMOZDURZiU2vqNASJUIrb3Tgq7yiFqFA
Pf6xVBBZ0b3wS4I8FcWzyOnSs8PWGPTHQfUbeCqDmD1IBH6BYpTnzwS114PXZaNk
aThJnaYVEzhR5LZGCbfpfNMeDyKEXCOk99R7H7UCowBEAWBdzziZ6vz00sDLrACR
Z8pe4s0EqklPtYYBNqMu/OMR5Q5R5wJIGIrr0LiEZFs4O7vZ0rfDaqOw5N+f7VQ4
16vL4aTPIR3g2F4ehzUFldgL/Q5LdQlaTO9cGJ+x4B1Suim72Wboe0OywIeUlJXy
Sq7c+MHPHiEw/PnXrnhHvjjBV+vFx8UfR0wLyVge9QILofkccz4SiEzu9CClNDBN
O6TbXLcMnB3OsakT+qHe16dk5PuMKfIC+XUgA9DrXlKLgHt8yc+eJUQLJcMBGrmO
ZtHiCPbS2Qz3htw0LZrY
=V7E/
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--
