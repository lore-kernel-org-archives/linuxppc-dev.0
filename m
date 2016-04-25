Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qtwBf3MpRzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 04:44:58 +1000 (AEST)
Date: Mon, 25 Apr 2016 19:06:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Caleb Crome <caleb@crome.org>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-ID: <20160425180613.GR3217@sirena.org.uk>
References: <1461606624-130216-1-git-send-email-caleb@crome.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RCQbRqFVGRR2abej"
In-Reply-To: <1461606624-130216-1-git-send-email-caleb@crome.org>
Subject: Re: [PATCH 1/1] ASoC: fsl_ssi: add CCSR_SSI_SOR to volatile register
 list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RCQbRqFVGRR2abej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 25, 2016 at 10:50:24AM -0700, Caleb Crome wrote:

> Due to caching, SOR wasn't written when it should have been.  This
> patch simply adds SOR to the volatile list.

Could you expand on when it wasn't written and why it needed to be
please?

--RCQbRqFVGRR2abej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXHlyUAAoJECTWi3JdVIfQH7QH/iiFtjnWj6/tyzk4VnfXeKLj
t6mfUR7Gd2cL1OhVsDg9HJJ2hhuxw/FuOK20MRE2UZbdhMGQwZq0zfpNs1bp+JIR
MhzF1GFfJrRvY6HbsKtk/mRvUysPKjnWuV8UwA2Ec0W0Kn7AKfib6TO10HSNag3I
UEfH66jQZmOle4mSmARzlHDyZvplDp9W+ABqQrgKNObUjJVEfZJRm2C5xOaAaABB
RxGVnEJjcBK4yaCSITI51Lqs12V7zgDDg2fndkqQjA1zQG3du3N0CcTCIYCsxt7K
n2HHvnG/oDYQs3wrz9w0d+DwQX/GD0AQvg6BSvWQz2CIRM7O3bEDFoACTi7o7Y0=
=ew4i
-----END PGP SIGNATURE-----

--RCQbRqFVGRR2abej--
