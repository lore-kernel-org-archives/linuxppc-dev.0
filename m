Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B16A32C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 05:11:57 +1000 (EST)
Date: Thu, 25 Jul 2013 20:11:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <b42378@freescale.com>
Message-ID: <20130725191148.GP9858@sirena.org.uk>
References: <1374745301-29508-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/iFx7UFBKvQAxELg"
In-Reply-To: <1374745301-29508-1-git-send-email-b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: Set sdma peripheral type directly
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/iFx7UFBKvQAxELg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2013 at 05:41:41PM +0800, Nicolin Chen wrote:
> Let CPU DAI drivers set SDMA periperal type directly to support more
> dma types(SPDIF, ESAI) other than only two for SSI.
> This will easily allow some non-SSI drivers to use the imx-pcm-dma
> as well.

Applied, thanks.

--/iFx7UFBKvQAxELg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR8XhxAAoJELSic+t+oim9I4wP/0gVqoqMaLeA75LA/ggwrtpL
iBbJdmVE4vPeYLmpYGgHvES1BDMpmgA/EXalVulhdoaCUa/V5MjQiMrU97sw8YQs
GpUEg6pcVFB+iBZdnt43Tr5rQusZ2OAalURhW5atAGKFqEn3/2sbQtMbU57/B3Qz
vZOiBS2hx7eIlN35wbcbFox70MB351fVolmD7NdLzYx08P5XNfss4B4lJ3OrblV/
eEBSBwTiBftAkSMnb3KyQniACxHV2jKAyp7GDymHL+yl1/qQ5jFDurz/5co3BvzL
+FufAU4/VA8i+jbHpmaep8NzW7xVWGYq+1nRNRvZ64/1TWFaSXV+3Idk61hHYLdh
H49SnUfNOLhgLyMg6wCZ6xTIafOVnrccEU04zk/8WtxS4kHDGF8JN+Osq5nXLZJu
/QQSVBkjVgH6/4eJ4cX1HFkgTHU5bncvjp+uz/ks1+o6MITyvbgAU+pYotzR/BiI
/BPYPO91xfuqFkPVw15f0NTpj8a6wsy72yO+rcKOH+92AfYmRo1eOdTq41mj1ERz
H8DoDml2yvtlnnucN0NgmqHBc0ayhAZXaTVVgG/xJFrLzLWu8qyeCM+NgbRZXn/G
QAQQUKi7H7PUv4gflByhCS21EfmgnKzZX5nxF6PYxXyb/tELQUn3m8xOrl5Q8sMM
bQPG1gFmMqL1/vDOKhzy
=ygfU
-----END PGP SIGNATURE-----

--/iFx7UFBKvQAxELg--
