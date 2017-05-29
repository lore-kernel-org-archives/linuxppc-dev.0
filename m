Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbyNK5bxmzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 23:32:49 +1000 (AEST)
Date: Mon, 29 May 2017 14:14:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, johannes@sipsolutions.net, perex@perex.cz,
 tiwai@suse.com, clemens@ladisch.de, lgirdwood@gmail.com,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Message-ID: <20170529131427.mezkiwcvo2znkekz@sirena.org.uk>
References: <1495896375-30855-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cjo5vbwv4cfjepq3"
In-Reply-To: <1495896375-30855-1-git-send-email-bhumirks@gmail.com>
Subject: Re: [PATCH] ALSA: declare snd_kcontrol_new structures as const
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cjo5vbwv4cfjepq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 27, 2017 at 08:16:15PM +0530, Bhumika Goyal wrote:
> Declare snd_kcontrol_new structures as const as they are only passed an
> argument to the function snd_ctl_new1. This argument is of type const,
> so snd_kcontrol_new structures having this property can be made const.
> Done using Coccinelle:

Acked-by: Mark Brown <broonie@kernel.org>

--cjo5vbwv4cfjepq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlksHrIACgkQJNaLcl1U
h9AQ6Af/SYHN10JcudGoHosgxab47NA+Ypt7AjxkfRA+CJgA1NRGvTmopRopFf26
79SWlGmaMbSVmtZdMB3Iq2PaFWJCF5Ox1MrXkrPtv0lGxpHVWHXo/7yL61T7POB5
8wg51DokQyzlXS/7dL/bEYDajeRUVTJEn5VanevXgv4Efa1z6BAbZtB+uy6r+wZ1
3NWo1C/V/tQ3ziK/Bv7CSimVX3hSXninjPnFq3pvXyyiYSsg6Km/4K4HxRpU5RDj
t1RvvmmtAGEXpneVcCTCitoIgpa34QNl2p/mqr6EDSnA25+SPJ/CGpz5BIxO6G+6
da09+Y5lFnjAzj6fop4CUEaWswpp2g==
=PVxq
-----END PGP SIGNATURE-----

--cjo5vbwv4cfjepq3--
