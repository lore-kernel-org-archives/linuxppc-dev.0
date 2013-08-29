Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 77E832C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 22:15:53 +1000 (EST)
Date: Thu, 29 Aug 2013 13:15:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <b42378@freescale.com>
Message-ID: <20130829121541.GY10783@sirena.org.uk>
References: <1377662686-31696-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dlFvqfizQ5ooaSx9"
In-Reply-To: <1377662686-31696-1-git-send-email-b42378@freescale.com>
Subject: Re: [PATCH v12] ASoC: fsl: Add S/PDIF machine driver
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, swarren@wwwdotorg.org,
 s.hauer@pengutronix.de, tomasz.figa@gmail.com, rob.herring@calxeda.com,
 p.zabel@pengutronix.de, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dlFvqfizQ5ooaSx9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2013 at 12:04:46PM +0800, Nicolin Chen wrote:
> This patch implements a device-tree-only machine driver for Freescale
> i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> fsl_spdif.c drivers.

Applied, thanks.

--dlFvqfizQ5ooaSx9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHztqAAoJELSic+t+oim9qEQP/jFayl5Tl6OcYz0p/4MyMs2G
zbTHT2TMdlP6AlyVI/JYgNpcQbVLwdUppL51xtW3WF3G907ymD11FxV5lunj7JsW
QHJ1OQISn8yiyECma/fvhtSbzitsdz0XR64L1b1GTJvcXmaMBLqx+m7xlYlG1guY
cEcg82RoF6OkGUtC6hEIXvzjWidGTF3NQk8l/0NpHp14mfK89WJdBGNihmcflM9U
BvqvV94Mz04EW9+6BpKdBoyyZ2XaqmtA/07+tK1CIDJF279bBtUm/TDNwdj5F+l3
e24nprKj4kP5gdNrBTfpU29ub6l7lPK/l7grH8o2tmv3icn3VI4JbMH4LnhxqvC5
+7xTVCKKHFNGl6BBEZk/9NEcUhqTuyurOApsez3xxaYxsZrY03wiv/JFQSUjYlrD
QZtruaF9XrBuNX7GjikDt4CYRBN3V2uWBYRFXAO3/evKzpyDk3RSlX7iy80ZEZUu
SSSOFjjtFWdXyQ72qho8W1LcO0K6hlHghljzlnpOgxbNhIwnt+3UCweZ98mj2Wn3
QOi84neVP6GA3CPY8Mf7dZKL6ROg0QlrNWXHsypdnMDSLBq8mWYWl+DG6X0Nd0W0
UmFzjrOs0rSFQoGr2NkoIGgIZkw3ywHy7tAT1qftESzwz69KP4t/AVlLDBo6ayZM
ZQjXAskUVp1N/awbZzvx
=vaI1
-----END PGP SIGNATURE-----

--dlFvqfizQ5ooaSx9--
