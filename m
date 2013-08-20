Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3AA732C0102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 05:07:13 +1000 (EST)
Date: Tue, 20 Aug 2013 20:07:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <20130820190701.GR30073@sirena.org.uk>
References: <cover.1376912873.git.b42378@freescale.com>
 <ca3061d70ab8bf59afc59031fa7befcfaed26d51.1376912873.git.b42378@freescale.com>
 <5212908E.6050104@wwwdotorg.org>
 <20130820001858.GF30073@sirena.org.uk>
 <52138FDE.3080007@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HbrDUOEqlDe4KvYA"
In-Reply-To: <52138FDE.3080007@wwwdotorg.org>
Subject: Re: [PATCH v8 2/2] ASoC: fsl: Add S/PDIF machine driver
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com,
 s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, timur@tabi.org,
 rob.herring@calxeda.com, tomasz.figa@gmail.com, p.zabel@pengutronix.de,
 R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--HbrDUOEqlDe4KvYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2013 at 09:48:46AM -0600, Stephen Warren wrote:
> On 08/19/2013 06:18 PM, Mark Brown wrote:

> > S/PDIF is also sometimes used as an interconnect between devices -
> > some CODECs have S/PDIF I/O (more normally used as an external
> > connector on the box).  This is most frequently seen as a way to

> That's not a good argument for an incorrect binding.

The point is that it might turn into a more correct binding depending on
what the S/PDIF device actually is.

--HbrDUOEqlDe4KvYA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSE75RAAoJELSic+t+oim9X8sP/jbZDHKSmMmm0kUmC6pZb72l
V0IwU8zfK6lWOwG9xtsIBgD7QSNIEX0+1DzBxyvsk9v3eYhKI6Qsj7UPLCJqdNEN
CR93bN/Z7STcAegkVxVpyp2R1cjjqjEYEgRhjCud52gc63wO2YNdhl4TqVdwr7pn
z6XK2MUsotoHxVLX8dNwdv5xVKRL0wYCGZ7ju8TJN7quQUd3BAtsziM3pXqx4Ggj
Jal+PP7EaBzWJ0y9ZiGLwngWn77W3QwXBuWGLdF03pwzyL+ls1GXSw/ObfE6L97G
wW2Q4IMjdrLVLTSSesNcf2S8/FUm9q5pllZYZs1bB/UVb8sSEdRLsDTNfB/+IpLc
spZYPQXJJTZMSVa3/uRjjTVJAxKQeZZq49LsJIN97xPa+0JqK8y2eeDexPO7c+kx
PPc+NTULBjUoXDTy561vxJkhc/DqRKGMbH11+zQE+JwMACWb/tKGFbZdsbAN5zJ8
HLd2JbzT7mwlFBErSuCZsV2QtpWFAU0XjaB69WNfWvziHfrXqXYMELuc35r3nRCM
SwpB67l4VJ2lQ4cnx8rr+8TXOULOp5H/WT/cwB2hDtH8C/+GBS0SGZUCxnVz9kvP
lscQK7YXvQbHsiUqPM1DcylbBuGq5sX7eVOw/pFo9D+U2mZq8F6amYcTyPa5EhXj
pEnmlPSggZLT8KwL6o47
=QqFN
-----END PGP SIGNATURE-----

--HbrDUOEqlDe4KvYA--
