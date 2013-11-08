Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D52E32C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 22:45:18 +1100 (EST)
Date: Fri, 8 Nov 2013 11:44:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <b42378@freescale.com>
Message-ID: <20131108114441.GM2493@sirena.org.uk>
References: <cover.1383907685.git.b42378@freescale.com>
 <20131108112919.GA5159@MrMyself>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vYlOGI1a8wP+YbIl"
In-Reply-To: <20131108112919.GA5159@MrMyself>
Subject: Re: [PATCH v4 0/4] Add dual-fifo mode support of i.MX ssi
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 vinod.koul@intel.com, s.hauer@pengutronix.de, swarren@wwwdotorg.org,
 timur@tabi.org, rob.herring@calxeda.com, linux-kernel@vger.kernel.org,
 ijc+devicetree@hellion.org.uk, dmaengine@vger.kernel.org,
 dan.j.williams@intel.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vYlOGI1a8wP+YbIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2013 at 07:29:20PM +0800, Nicolin Chen wrote:

> Sorry all, I mistook the version number. It should be version 5.

> Please ignore this series version.

There is no need to resend for things like getting the version number
wrong in the subject line, that's just noise.  Please only resend things
if there's a change in the actual patches.

--vYlOGI1a8wP+YbIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSfM6mAAoJELSic+t+oim9awQP/0qHWvJ9Nnz/8tr9RuT9ALD3
hZqkVqGUMpmCsRuCgpGWMqw+BfTa181ivuRaIhgB7sJaFp+F7Herz0cdUfft+5dr
1OiI/HRAgJPorCRRLpJV8tGHClN2PFTW6eAs33esQuMye/LDgezrpCoz7fWRhr0V
ocKnVJdzLL1nc1nA8HpB2MibaStHHv3yB6OQHVDzzxiaH6/An0cqPGF6RUYYsiC1
MyudSXDkUCXvZkDgX3b48VV9jc6qERMbnobUuaEJ12B18aUtnHAEtjHzpJeHz3qt
ZbYPRyskYtCwxPFxg3+hEERrGJYOm9r0qQatdvLCVSYe360VBOHkVdZrhKZEmXA8
zji2NpmpkCwMqnarnQwPTjxiA6Ct4hvr9pw7PdzRBfz5mhQxJHV/nszqbraGOBvz
aMBgTzrZQeT4IqMhtU+L5/GFKvCZliQA7F+WrR07N36O2tvBSS+VYF/PrDZ/2Yiv
H+VpZCeSfwpA/EWDYHcgNBu/Q9xLvlfKYuTJOkHYHrzrgXsP0qLBhuHi14wNn+4e
LcfHLfbXE3L6pP4y54nTaUgd+bmX1cN3IJQCW4NwqSsml08CWnZgwQZPeKznoprk
4q9EOrDGuKQ0ttgAEDQWN5kJ4iUak8gD3bnEzPkYev6NORBaHaoZinI5AkrQj2B4
uVoK66I3Hyinf006EdWh
=27sP
-----END PGP SIGNATURE-----

--vYlOGI1a8wP+YbIl--
