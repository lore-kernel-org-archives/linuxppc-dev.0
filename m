Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E50E01A0216
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Dec 2014 22:29:16 +1100 (AEDT)
Date: Tue, 30 Dec 2014 11:28:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20141230112859.GM11764@sirena.org.uk>
References: <1419898431-11336-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wxsv2zsxQJemov+e"
In-Reply-To: <1419898431-11336-1-git-send-email-nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Fix incorrect xDC field width of xCCR
 registers
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, festevam@gmail.com,
 Xiubo.Lee@gmail.com, timur@tabi.org, linux-kernel@vger.kernel.org,
 a_bouin@yahoo.fr, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wxsv2zsxQJemov+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2014 at 04:13:51PM -0800, Nicolin Chen wrote:
> The xDC field should have 5 bit width according to Reference Manual.
> Thus this patch fixes it.

Applied, thanks.

--wxsv2zsxQJemov+e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoox6AAoJECTWi3JdVIfQCz8H/0X2DG9RkZpqduu3gEjXZDl8
qUeuoP1nXkh3Gv9Rft+mFvycXbwmwbWXRV81H/bwQFTDOg8JrsAxiOZw+oDBAkaA
UsrpzTXTmt7oCSHcxYqB9Bt46krvktOfAj0ii7VynbdhPEqBjVg9dQ4Sm+EdZiPd
kzMKLehlqDspWhIMEMlV6Nn2Tf8j1oXfIc6hcb1m5AI+VSds9uhvF9tQ1a7iaZB8
grvP1JB9IxngnvKmmwvynfavfcVfkc+cZHVbJac0ZUeBiB0aWTLKkecO9UWq7VZ5
8bULy361+1Ii5SnqN/d2d2IdML7WA3jn75/Wf+jWPL3crVCVCaeHd+V1pV2IYCY=
=2NqB
-----END PGP SIGNATURE-----

--wxsv2zsxQJemov+e--
