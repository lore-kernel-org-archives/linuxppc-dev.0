Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A2FE1A0216
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 23:49:54 +1100 (AEDT)
Date: Tue, 25 Nov 2014 12:47:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20141125124742.GZ7712@sirena.org.uk>
References: <cover.1414193668.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zrEArbvrm/ur3HOL"
In-Reply-To: <cover.1414193668.git.nicoleotsuka@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: fsl: Use dynamic slot width for ESAI.
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--zrEArbvrm/ur3HOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 24, 2014 at 04:48:10PM -0700, Nicolin Chen wrote:
> This series of patches add the support of dynamic slot width for
> ESAI driver. To do this, the PATCH-1 removes the fixed width. In
> order not to break those platforms that use fixed width, there
> comes the PATCH-2 to apply an override of slot_width.

Applied both, thanks.

--zrEArbvrm/ur3HOL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdHpuAAoJECTWi3JdVIfQuPEH+wU2vOjKzHpwHUpL0Q6P920z
XyUuRWZaWgL/wqp6ugDRcopn41Ow4IrngI9Ju/Fx+GOM2jjUupBScqOUkh+dPLWE
lQ8kwpRw0CZld59Q2W2hBL6VmCG8njGmZ7W6Q4F0wtdPfEjk89wE35b0qSsis2G4
xovNV+kmMBozkXS0FF+26bav3k3b1Ppk+SEG77bmL7BbjWDI/QFtoSZPF+28tpkS
XbGLU9yrz8+UvvJbqlHZ+flBISzE0RsskIR+5mBU0wD1Ms3ECgAWrvvR4UE4Lgye
NOelEPmcssGqNAwprwKP8XTh0urxtNTjNFIk4TQVkKbUHaXOAWN7s7KyT66C2Os=
=wNgc
-----END PGP SIGNATURE-----

--zrEArbvrm/ur3HOL--
