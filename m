Return-Path: <broonie@sirena.co.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xygHh13H6zDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 01:18:52 +1000 (AEST)
Date: Thu, 21 Sep 2017 16:18:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, timur@tabi.org,
 nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
 peter.ujfalusi@ti.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ASoC: fsl-asoc-card: Handle return value of
 devm_kasprintf
Message-ID: <20170921151832.6rs4gx6cft6tfdis@sirena.co.uk>
References: <d973fbc962f750ef87c0bccf7b2df6536c8e987f.1505971045.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cgn76rxy6rogobow"
In-Reply-To: <d973fbc962f750ef87c0bccf7b2df6536c8e987f.1505971045.git.arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cgn76rxy6rogobow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 21, 2017 at 10:50:03AM +0530, Arvind Yadav wrote:
> devm_kasprintf() can fail here and we must check its return value.

This is patch 2/3 but you've only sent me this one patch.  This is
missing the point of numbering a series, the only reason for the
numbering is to provide ordering within the series.  If you send a patch
separately or as part of a different series then the numbering should
change to reflect how things are being sent.

--cgn76rxy6rogobow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnD2EcACgkQJNaLcl1U
h9D2ewf+JiFmOniuOYGmxekij9kfGD32tPzXcQc/BDO6F9dK/1G02bmWVLlJjxwD
Gr5rRi8xFG4iXcE+usUyC6XzF9nMiDwRpgnJ97bLb0KgXtu4+0ae5fcsUipzfP5X
wxckZPZXa5ZC4MyzTVURO2TRlQkR00J6USHHHUPU8suZE3rIfrFyL71XSdxvcomk
dENs7o8H5Ovgw3AKulS8odT/fNs/9iTAOZCufnV3JLgMip8XsYfx9arxd3BWea0G
mV6nsZIgC5IAzyJf6tfxaNa9KIHyeKzQLKjpsyQ5wVaitwCOnxa7OEqAFWuB9Opv
pxxHgKnSXozSRv/4wULRU+KbcWlmGQ==
=XWBI
-----END PGP SIGNATURE-----

--cgn76rxy6rogobow--
