Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 516AF1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 08:37:41 +1100 (AEDT)
Date: Mon, 1 Feb 2016 21:37:28 +0000
From: Mark Brown <broonie@kernel.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabio Estevam <festevam@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20160201213728.GH4455@sirena.org.uk>
References: <569D3800.2040801@maciej.szmigiero.name>
 <CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com>
 <56AF4A9F.4060401@maciej.szmigiero.name>
 <CAOMZO5DK86JCs_KivZ5MMFKsiP6aVpopG-zgXPE-+_GWjQNuMw@mail.gmail.com>
 <56AF4ED0.7030801@maciej.szmigiero.name>
 <56AF8E9E.5000100@maciej.szmigiero.name>
 <20160201211017.GG4455@sirena.org.uk>
 <56AFCE8D.70804@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
In-Reply-To: <56AFCE8D.70804@maciej.szmigiero.name>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register defaults
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 01, 2016 at 10:30:53PM +0100, Maciej S. Szmigiero wrote:
> On 01.02.2016 22:10, Mark Brown wrote:

> > No, that's completely broken.  We can't do a raw read from a regmap that
> > doesn't offer raw access and we shouldn't pretend to do so.  If the
> > caller is capable of substituting a register by register read the caller
> > should take responsibility for that.

> So can regcache initialization be changed to use register by register read
> in case raw read fails?

Well, we *do* have full source code access!  I'm just blind writing a
patch to do that.

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWr9AXAAoJECTWi3JdVIfQJgMH/0UCO9vey3boCR0oRfeKlmXp
1qlEm3hlRdZ6l6cOUAlBZ7DomGwlru1dDAhtiOE3ZYC3n1LUxNC+//uhqFRkAVxS
Xmy5EGlMsctdUq0uVIF1VLx8sOfVhBUmH5IvcPv5jcbyr0HB4z4CHz03zK/XHLjO
+G8cgaFUSNnoERkzcaQFyszzSR5mIKQO5hgRpUCCIYGprrR4T8pcPjudu6+vIaBg
xnMVrij3l5xgFtmTdOnMeoySSBQ3mGWGMuPAsCZr+vBkzQ5KffvHB/4ulLugXD8/
CjvSNdPJEiVDQT5yJIxppONqu3O0cjMV2oM1XmJ1GWZbRbJKlTl0nbko1QgkDXQ=
=MikO
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--
