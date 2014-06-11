Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F2DC1A03CD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 10:05:52 +1000 (EST)
Date: Thu, 12 Jun 2014 00:34:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20140611233453.GP5099@sirena.org.uk>
References: <1402470832-24889-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8Ioc0IVuiHZoupes"
In-Reply-To: <1402470832-24889-1-git-send-email-linux@roeck-us.net>
Subject: Re: [PATCH] ASoC: fsl: Fix build problem
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>,
 Jaroslav Kysela <perex@perex.cz>, Markus Pargmann <mpa@pengutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8Ioc0IVuiHZoupes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2014 at 12:13:52AM -0700, Guenter Roeck wrote:
> Commit 432481220 (ASoC: fsl-ssi: Use regmap) removed struct ccsr_ssi.
> Unfortunately, the structure is still used. This causes
> mpc85xx_smp_defconfig and mpc85xx_defconfig builds to fail with

Applied, thanks,.

--8Ioc0IVuiHZoupes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTmOeZAAoJELSic+t+oim9vfUP+gL2Kunt8IHQpb2QCqBnQmCi
c6/4lVq8KM5yBWiAva8iaBvjjKUr1Wt757bDj0NYyJPMt2+mi/3b/Fy0uYZC1Vh7
Y/m5ZsWk6VDcu0fPLLYpsGvTcnCggLbEt+G5W8LFcv/Qijb26x315FnUkwvRd3B0
zMU9V/GfWmfmz4h6+YCMnhYE4b+qIHaAKcBW/qPJmlyWvZKhO4i/Hyz+fbUo+7SU
KiQgts8QUplKmyrHEP9y2pcw+W1swb2wueFDvKSJc+7l+qzgeMjS0yNWemCEybkL
GAvgFB+1V7x4hf+CziefOCkfeCDSkUpSbizZj/c63yKQBDw4afwTuGdcDh9xeHND
1YWHhE2MIiZnr55DjwvILhUHKPGJfZZNXWV2W4T+hGCTU+zX2XJ4Lc9PFUjMQkvO
Z6oa3H7NbKMcg+rCvF7XVhyQv85n7XBofWQIW2wZKGH6M3pn6S3FBW/GWIOM5rMw
tLA++QsvDYyuk4xMfTAnfUQvj6R00p8RrseDxx1CM55aX62OFLgSvwIESZOqQewe
/ZW38o59Iacniwb5vzSBkMx7lu/VULZJEt6BllVenDv6leOB18EH+f9lqnVgp70/
SUQoIo4g7xFyXz0fXDLnss4+K+4eYigwkH4abBRnKIGFwubnjRO3hNAhnOwDlBYW
j/ln3Yw0z3TNkklTE5s9
=Ck1x
-----END PGP SIGNATURE-----

--8Ioc0IVuiHZoupes--
