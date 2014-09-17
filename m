Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B62851A0027
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 04:31:36 +1000 (EST)
Date: Wed, 17 Sep 2014 11:30:43 -0700
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Message-ID: <20140917183043.GR7960@sirena.org.uk>
References: <5dc0f13cdb62904ae0f104f9112faec672adea6f.1410833402.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SorlIzCW0DSU55cr"
In-Reply-To: <5dc0f13cdb62904ae0f104f9112faec672adea6f.1410833402.git.shengjiu.wang@freescale.com>
Subject: Re: [PATCH V4] ASoC: fsl_ssi: refine ipg clock usage in this module
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 linux-kernel@vger.kernel.org, timur@tabi.org, perex@perex.cz,
 nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, mpa@pengutronix.de,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--SorlIzCW0DSU55cr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 16, 2014 at 10:13:16AM +0800, Shengjiu Wang wrote:
> Check if ipg clock is in clock-names property, then we can move the
> ipg clock enable and disable operation to startup and shutdown, that
> is only enable ipg clock when ssi is working and keep clock is disabled
> when ssi is in idle.
> But when the checking is failed, remain the clock control as before.

Applied, thanks.

--SorlIzCW0DSU55cr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGdNOAAoJECTWi3JdVIfQMDYH/RwLDNitdtxPsO8VST2UHb0E
IGx1uWvA+yJTVbJguO5NPuUWasSEgAzjBWPOxhsNNPOeKVut+LM1G633uZmLGlI+
nqSwjIYmrH1SWBy9Inw0sfJMgcvbZ1i2jfTHb8Fpkc3GgKQb95Hy6nTz+2PqxINu
x2hrVCpsf/1IjHcE56G47bLpXEHuyfqwRN1XxCbmX4Y8U+avQ/PPUVwW0f14s/Zm
VMvTZveqoLGg9V53TaCGXv/7JF9StICmZG3rEzmhIG7SXyOfUPwSYNvqaUY03g8L
Lr/dtHZ419yjLHXJICj4NbV+823G3f4iAPpZYk7+NWGEO/TZV70FzgBb3ziXi3Y=
=G/8g
-----END PGP SIGNATURE-----

--SorlIzCW0DSU55cr--
