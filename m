Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5C2AA2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 20:02:34 +1000 (EST)
Date: Thu, 22 Aug 2013 11:02:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Gerhard Sittig <gsi@denx.de>
Message-ID: <20130822100227.GT26118@sirena.org.uk>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-2-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vBRosIkLXbYTRpGW"
In-Reply-To: <1375821851-31609-2-git-send-email-gsi@denx.de>
Subject: Re: [PATCH v4 01/31] spi: mpc512x: cleanup clock API use
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>,
 Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vBRosIkLXbYTRpGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2013 at 10:43:41PM +0200, Gerhard Sittig wrote:
> cleanup the MPC512x SoC's SPI master's use of the clock API
> - get, prepare, and enable the MCLK during probe; disable, unprepare and
>   put the MCLK upon remove; hold a reference to the clock over the
>   period of use

Applied, thanks.

--vBRosIkLXbYTRpGW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFeGwAAoJELSic+t+oim9s/MP/j2rFnWIixLHWCFoDvQ/11sg
RC0ArJ13ELabQfRXY0y3IeIEqXqcEyoDv2ikjQ5nCoaWy7/g9XlXnmTzpu6rqn9v
V3g5r++7bqWMrd5XghFuPGixSsRGyRAHnCnDSUCgyF067VicfQ7RYSH/AT3LyJo3
IaVZby1CyPMfapPFK9UEXklUzpNpX72ece62S+DzCNKjPx+RDr9coW5UT2cGc6oc
JMHP7fdsCWnbDAvNj3BGOvjxfJDcoIogiYBMkvZGsKbpls8mh45K7/IRTLkbuipg
m6GFsQzpZMNnLwsAUAH4wUFeeZzurdiAs8Yl4Rghvbp3HlANdZshz71zMOKqsDqo
qlrb7htyqO8wK2vRq6qovqKDysBbiicMDalGle5wqeOJMtEInUyD/OOak/T7Vpo4
RgphHcGmUWJdAT+YLhe/aZjIUf1R48r+wpMCLOh5q9QAWkAAPz4XZvBScvBwvJh3
mw153pbuEEZdyXSxUkGNyt3IHE3OoWTzgNa/LSWscZnsMXnhXCTZHMgUkssvemrc
2B5HNGD40N2n0aSPg4a4QHrIc3jS+Y0/ri4pMJZnUFo5ldTL9nonblafh5alGpPz
4FRwl/HjGLxec8y6SdGHzGxhcGVI8BLpbLSaLHhoyBw9tlPiStdU4CEWiW72RHtS
lq2l85gqYTcfhs4j09Ad
=K94d
-----END PGP SIGNATURE-----

--vBRosIkLXbYTRpGW--
