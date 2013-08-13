Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 07FA32C0102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 05:03:06 +1000 (EST)
Date: Tue, 13 Aug 2013 20:02:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Message-ID: <20130813190255.GF6427@sirena.org.uk>
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
 <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wjVsQm+Lgir5jV8i"
In-Reply-To: <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de,
 Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com,
 p.zabel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wjVsQm+Lgir5jV8i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2013 at 02:58:26PM -0300, Fabio Estevam wrote:
> On Mon, Aug 12, 2013 at 9:01 AM, Nicolin Chen <b42378@freescale.com> wrot=
e:
> > +Required properties:

> > +  - compatible : Compatible list, contains "fsl,<chip>-spdif". Using g=
eneral

> Can't we just use "fsl,fsl-spdif" instead?

It's better to list the specific chips in the DT so that we can quirk if
we need to later. =20

--wjVsQm+Lgir5jV8i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSCoLbAAoJELSic+t+oim92QEQAJtgHlioikbwNtas7ayRGfgb
rZQXCz6RCD/YbZ/BGScMsb8j/NyuxpNGeOu/icmId3IOQfu8CZw84Zw+1swL/hue
LzVlUbrbd+miFgMAvK4PYSYLv1Pb8y6TMUxfncroYXqxtJJPRFd+8wFH9lEqdAYK
QeKmxP426/W6dBzhTx/6fJxvsxNpCDahuUwi/GHPCUvEwkoFOl0UjqYNM22H9v6X
lHzsk7mO3Z4Mo4iWbs9YZGZjNOD95tOL4891OQGk6Fq+brVK3ID8xMtwLqyg/K38
gua4xLXbcnF0BXxNtvxFlXZu2gISQuopwj77oo/A5/HTtFh0Gn0cQKk+OU3mSN7X
QIy+uLS61e1WWT8D6E6PKl5lcuFSnTDHS57Ep2eH9YWNnRYYCVwE8QGKMEeOQ9PI
UcQOhz8THEN3eOTbB0L3of//hleDJ6c6bVeR+PH+j+QH2JhP7Y5SvcDGyz9sl9SX
QJ9Ir/zxn+/895UKzDzi4MvebaqswIOiY2w/387MxAXH49HqVoZFtHb76w1bv9jT
naiQk09BbhMcTNUDGyaslt94lXDWnzDHtJpzlSDV6+/0i3VM7mrpTplWOreIQKKT
716mwhN8zMyXK8KjT+b/px4jt/RBFlzgMhAJ69UNyjKVdFkK0J1l7ap6smGmGyXS
stdX2YGidR3c1+x3YekH
=pf6Y
-----END PGP SIGNATURE-----

--wjVsQm+Lgir5jV8i--
