Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 85E7C2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 05:11:19 +1000 (EST)
Date: Tue, 20 Aug 2013 20:11:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <20130820191113.GS30073@sirena.org.uk>
References: <cover.1376972170.git.b42378@freescale.com>
 <03182ed7464c156ec6345194d3f7ec920f753c2f.1376972170.git.b42378@freescale.com>
 <5213965C.6010908@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EVTdUHOLdMfS4dQd"
In-Reply-To: <5213965C.6010908@wwwdotorg.org>
Subject: Re: [PATCH v9 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
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


--EVTdUHOLdMfS4dQd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2013 at 10:16:28AM -0600, Stephen Warren wrote:

> What changed between v8 and v9?

There was a changelog in the cover mail for the series:

| Changelog:
| v8->v9:
|  * Use bool instead of atomic_t.
|  * Use clk_prepare_enable() instead.
|  * Dropped dumpregs().
|  * Dropped unnecessary clk_round_rate().
|  * Dropped unused clock source enum.
|  * Revised dev_err() message.

--EVTdUHOLdMfS4dQd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSE79OAAoJELSic+t+oim9Zj4P/iv7P0ItS1nWDA76esXebshD
y8ShZbwbuW4amp83+SrqM8LoMBMjwG+/25EoRjGsSDxwhcvC9h/+i8OAcr6lgaap
vxx67HwSrHGS0VJsGAAcm5GfehNhI/aa0Np5iDm2cB5BwayJ2HhR6IsecFwu8VcM
NtX95Dca2zwbNyyA+EPNDaXahqi/x62YO2ElO0qOZKj5XdLvg2f/BRrqY8nAlnSZ
C8c5BYE5/xThfFoZFGzqzJSiPLJkgwLVwV9iyiF0s+x76U2xAHurE9No8mmHiKyw
ep1ZN//T05GrXVslc50bhOArHoGnN32xvGQO0OJwNJ6S1zTUmoQhKDZtA+Wkghiv
ORDiKx5HpktgaqfM4V13h4IsziigWE8cBIZKjs+C3CQ9wuld7L2pG51Jx3PSqGpo
5cz3nTNiWN+ggvKykqB+Yzz8TF9nc+76vcgP2h5gLsASulnjJO4ck2Yy/mWigneE
8/cgHzT29/dXLzhOEgjFtR9nG44KW67slSnqA+qB8v6od1v1Obn8Ph+7I6W864eh
lX6tDh8uMWvyaXO+922uquvHOzdupj4BOMxxFj/PfEyXPudKuYVXyxHENrd07yW7
x7u0UFLZR0TXKDkvWNWM7Xvcza77ywMSPnF4qYY/UUpN858exHvhp+4emXXRUhSz
SUVpB6nstm8eBGbarPbh
=TEzj
-----END PGP SIGNATURE-----

--EVTdUHOLdMfS4dQd--
