Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2CD912C0370
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 05:37:32 +1100 (EST)
Date: Thu, 31 Oct 2013 11:36:44 -0700
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <b42378@freescale.com>
Message-ID: <20131031183644.GJ2493@sirena.org.uk>
References: <cover.1383226444.git.b42378@freescale.com>
 <dda0bc1221f053405da616192577228c51821040.1383226444.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3qYtBtpdm1/OJWPn"
In-Reply-To: <dda0bc1221f053405da616192577228c51821040.1383226444.git.b42378@freescale.com>
Subject: Re: [PATCH v4 3/4] ASoC: fsl_ssi: Add dual fifo mode support
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 s.hauer@pengutronix.de, swarren@wwwdotorg.org, timur@tabi.org,
 rob.herring@calxeda.com, linux-kernel@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, dmaengine@vger.kernel.org, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3qYtBtpdm1/OJWPn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2013 at 09:44:15PM +0800, Nicolin Chen wrote:
> By enabling dual fifo mode, it would allow SSI enter a better performance
> to transimit/receive data without occasional hardware underrun/overrun.
>=20
> [ Passed compile-test with mpc85xx_defconfig ]

Acked-by: Mark Brown <broonie@linaro.org>

--3qYtBtpdm1/OJWPn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScqM0AAoJELSic+t+oim979EP/ieHTZ0VT5K4I6Ckrka4bOI6
aBBG8IVjrZVySOgn2G46HDEo9xG9Qr2X1+BDS79mlEG1oFliMgRgLdPsSENSiWUx
qg6goC+kS6pqTR+kHykwS9JRRiwpIK23gsXDsQOx0OVk5vdeqYVlgD9fTAgt/Dd7
3dmKpzpuQzxLDrNPiU2VYBZd7rcRwU1uJXfUZ6TqE+4YKWyW0faEaQ/BNzgOS0BC
pqeirRELxXT6ek5G3I5Xms1iVLneJqKh11leOkfCQvu3+M8TNLt1d10GWE9zbcx9
A1kDmOkDVFPNW+igunUhEuBgBBZbdSQzTV2ObiaNvd23zs0HN/tyBAD6gGgYi4yj
3f9ZOSvAc6kzW/by1Ey6L1BHbgTAYMNwB5G6s/JJPMF3qhnL92ntschYtWMAIJvZ
Xgn3OxXCRVm7LbAWEmh6VomqYTdQGEdWkZAESAoyqh0sZsM5Sg00fStbKS6kmItr
1W1SsaBPr8G/s/qV4MAGTrJzIU9hQcMLpfLBg8YkB1AZNn3dqKfOWfms+EFOwH95
3NDjKl8FqBVFUy18RFLmdM2wr2LxdrGTPfvZRK7j+nKjne4e/sa3KwUDce68+Ocj
AVgJgc5L03hIuWVlB2Brrax7IRV0G1xh/iGwTTJg/dv+On40ASAZCgeq5t7LJ5sp
UC3BOQJUTqs38rWNSZKO
=76y0
-----END PGP SIGNATURE-----

--3qYtBtpdm1/OJWPn--
