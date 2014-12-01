Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D07DD1A04CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 06:42:20 +1100 (AEDT)
Date: Mon, 1 Dec 2014 19:41:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <20141201194147.GP7712@sirena.org.uk>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
 <20141201065046.GB27289@pengutronix.de>
 <547C9C34.9080602@metafoo.de> <547CB817.10806@tabi.org>
 <547CC407.30308@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="A4pi7p1avD4z6Uqy"
In-Reply-To: <547CC407.30308@metafoo.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before
 irq_dispose_mapping()
Cc: alsa-devel@alsa-project.org, Jiada Wang <jiada_wang@mentor.com>,
 linux-kernel@vger.kernel.org, Timur Tabi <timur@tabi.org>, lgirdwood@gmail.com,
 nicoleotsuka@gmail.com, tiwai@suse.de, Li.Xiubo@freescale.com,
 Markus Pargmann <mpa@pengutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--A4pi7p1avD4z6Uqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 01, 2014 at 08:39:51PM +0100, Lars-Peter Clausen wrote:
> On 12/01/2014 07:48 PM, Timur Tabi wrote:

> >A quick grep shows the following drivers that call both functions:

> Most of these drivers will probably work fine without irq_of_parse_and_map().

I'd also note that quite a few of these drivers look pretty legacy - a
very large proportion are for old PowerPC hardware, though by no means
all.

--A4pi7p1avD4z6Uqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfMR7AAoJECTWi3JdVIfQxC4H/Rw91cGM/GoVnm+lMlkCjMT8
b0OZH4hfeGQfs5roSNkjab0foHUwXfKEmOcUnh4eHUiO3OJdAuLA2s4LWWKwf7Tp
I8+oYR268oi/uf4bhiREBOzrbj3+I8gqZmE7C9lXi3VVqjJm+/CgsoK+C+ntcf0N
LSJMaOMPQtu5CAAQNlSJCsaGbCdAdhEKOBTRyxaPHrR9HVnBI3nwXqthtqhntZDw
JMIlHh/v5rJsFW4oWuX6ym/g0VHQ2jvdmJJ9doJrrHdODdJrW16CYAU8ATY9iIY1
D+MMxQqoPYYfATRC7i6IkD+pKXxRm9PEg6efhPR89m0sndwXDTrCvzNBQRvdbgs=
=DYcS
-----END PGP SIGNATURE-----

--A4pi7p1avD4z6Uqy--
