Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 631EB1A0D0A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 09:48:34 +1100 (AEDT)
Date: Thu, 4 Dec 2014 22:48:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Jiada Wang <jiada_wang@mentor.com>
Message-ID: <20141204224810.GI11764@sirena.org.uk>
References: <1417499707-3125-1-git-send-email-jiada_wang@mentor.com>
 <1417499707-3125-2-git-send-email-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="y96v7rNg6HAoELs5"
In-Reply-To: <1417499707-3125-2-git-send-email-jiada_wang@mentor.com>
Subject: Re: [PATCH v2 1/2] ASoC: fsl_ssi: fix error path in probe
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, arnd@arndb.de,
 lgirdwood@gmail.com, tiwai@suse.de, linuxppc-dev@lists.ozlabs.org,
 timur@tabi.org, linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com,
 Li.Xiubo@freescale.com, mpa@pengutronix.de, festevam@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--y96v7rNg6HAoELs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 02, 2014 at 02:55:06PM +0900, Jiada Wang wrote:
> SSI component isn't unregistered if fsl_ssi_debugfs_create() fails
> in probe phase.

applied, thanks.

--y96v7rNg6HAoELs5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgOSqAAoJECTWi3JdVIfQmD0H/2cab5BQ49PiKU7DBqR4h0b/
3ieozrSYda0JOR2zNNCKB2LSzHI2heenBcd7cvCCM8rMIhHAsaGdBx/Df/CGMmmF
BQLuEzpzpbMVXrBO4fhdT6gJhZ80/eBwmCIVQQwvN+6mbr8yNm6nW/9j3wZaxDiX
iJSKtcqwjMXxTtBvZWKAFNXIPoIOu3loJpXkKyaz09eGm4tunpwzLzUysAZWViLE
0Uel8ypnGkGrvk54k2csKDrOOrEpveWDtmP+vEX9KOQ+8zgRb5rBJWXC+UTSDrUD
LMQ/RmMrfCl3Epzuor14zl1uf2iMlxmP0TmhsNW8v+crzkTOioa20NKELmrqZjs=
=iPDz
-----END PGP SIGNATURE-----

--y96v7rNg6HAoELs5--
