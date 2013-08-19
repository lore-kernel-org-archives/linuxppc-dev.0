Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 59CA02C0085
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 21:45:32 +1000 (EST)
Date: Mon, 19 Aug 2013 12:45:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Message-ID: <20130819114522.GC30073@sirena.org.uk>
References: <cover.1376901081.git.b42378@freescale.com>
 <e7ceef74714bb4ead624b333ee3969225b4c5cb5.1376901081.git.b42378@freescale.com>
 <20130819092458.GE3719@e106331-lin.cambridge.arm.com>
 <20130819095042.GA11402@MrMyself>
 <20130819100143.GH3719@e106331-lin.cambridge.arm.com>
 <20130819105201.GB30073@sirena.org.uk>
 <20130819113121.GL3719@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="o9w4P0ZCTVHZJ0iX"
In-Reply-To: <20130819113121.GL3719@e106331-lin.cambridge.arm.com>
Subject: Re: [PATCH v7 2/2] ASoC: fsl: Add S/PDIF machine driver
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 Nicolin Chen <b42378@freescale.com>, "timur@tabi.org" <timur@tabi.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "R65777@freescale.com" <R65777@freescale.com>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--o9w4P0ZCTVHZJ0iX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2013 at 12:31:21PM +0100, Mark Rutland wrote:
> On Mon, Aug 19, 2013 at 11:52:01AM +0100, Mark Brown wrote:

> > This is intended to allow userspace to distinguish between systems that
> > are electrically identical but physically distinct, for example when
> > multiple systems are derived from the same reference design.

> I see. Surely if there's some meaning imparted to userspace by the model
> name, there's a contract there that we should document (the set of valid
> model names and what they correspond to)?

In theory I guess.  In practice I doubt many people will bother and I'd
expect zero productive result from those that do.

> I'm not sure I understand why userspace needs to know what the system is
> if we've adequately described how it's wired and what its capabilities
> are. However, I'm not at all familiar with the way we handle audio, so
> please forgive my naivety there :)

The physical form of the system can have a substantial impact on how
people want to configure it at runtime even if there is no software
visible difference.  Coefficients can be chosen to work with plastics,
or volumes adjusted for expected user positioning with respect to the
hardware for example.

--o9w4P0ZCTVHZJ0iX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSEgVPAAoJELSic+t+oim9ksAP/2Bgg1B+z3G9u3ScZp230xoo
4d6MJq8MBUH4TeuaJcrt8lXt4yYB4Tu66gYEDnUYaCnCNp3rjWYTkjAPmrtOEFds
0QuAx1wDTASRbpGPELimQol/IyxcGRxDkffFoWpnkK5tGRn/30oINEK7NPEub7sU
96E2BuGEgzLA3r2YPQKcfb9tqzKFeNBJD3G25h4GQd7tRU1UCMGhj2XXOIU1vsDI
KM3Zea0/2M/mqBRv0k6SucDmD+yIyAyJjpRcn6zeqVgBdZDm+P3CfhfDOiNA0pOU
Vs0HMlo48MbN1Mfpg8oRCvIiwCOxtpV8otx3CZGE6S49+pipNT7FcRPa+mWJFgqa
F7sECi3habGmihKMWXE24y4d5/f+CCkK0y3XgVj+YSNBsufk9WSSiyyNx616w7DG
a0DIHXBKRrkgDssJ7oCmmJiU1n9m0166l2DY5ZnLwi7kxYnVnJZ0zmZcTiH1HxCA
dCnMmM0sdYg546yHr/8M+icec6HivmmUsYxPwjeOZ0hmSv7TVdd4xdH9YEbV703N
Z6g5pnrOGTdu56z8FThmcNCjVAC8wVDMwb1mHm2r269AUg97V088ZZfYjBdphmJo
77cowAdSM8FFl2AMqx5igLUFqglTR3Nrivx2OTzlzQUs2jIfD5Ma4gzxSW5NWY8T
2Vv7Xs86czSoFW0w1onQ
=5Tdu
-----END PGP SIGNATURE-----

--o9w4P0ZCTVHZJ0iX--
