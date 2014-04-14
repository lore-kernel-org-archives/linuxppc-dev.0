Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 98FA714008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 06:47:24 +1000 (EST)
Date: Mon, 14 Apr 2014 21:47:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140414204712.GG25182@sirena.org.uk>
References: <1397212209-7843-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Guq+xBHXhbnAFmh4"
In-Reply-To: <1397212209-7843-1-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Use FSL_SAI_xXR() and
 regmap_update_bits() to simplify code
Cc: alsa-devel@alsa-project.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Guq+xBHXhbnAFmh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2014 at 06:30:09PM +0800, Nicolin Chen wrote:
> By doing this, the driver can drop around 50 lines and become neater.

Applied, thanks.

--Guq+xBHXhbnAFmh4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTElNAAoJELSic+t+oim9iXgP+weBmtyfBPeAKMJC/zleWfsp
ReScJItytUOYqXncWS75lLIsr5wZ0TCa+t2xIrqLTqPYIfmJpCuU+tdtUElnPoSg
YQecB5SRZTuOFlxfcN+WGT4u2jMITKX0Kyr4ZMxhun+a52RBltybvaLUEXkfVGFY
ABv+blRda5+DYl4BUH9AX2XSXmxhqGRjmcjdXO1ZeUv2Z/R9U/6mE3xnX7BAanLZ
Zfo3p48zGyVDJFDXlReTfA//XPSkjZ3NDsmJv+AW9ZUE8yPEd9BdyYbdPChaPd82
klhQyy6o6pfu3t9kcLMpzm/zMsnwz25crchZYoL8LvOocs6k58wKIACp9vWPyZ+h
6oZlRm7ymlW48jvM3LCaCQhWJaKtmr2C0Ou/PiLA+BMw35ZKFUS1jNcomhY4fXl7
dETsMQQ4wkQO3GC5Kb18IGt/MJjKcM8AoNf23PGze01bDSVnpZa6nnfpOxau5B62
VcQ3AZvZII+FrbfH0Zy6wDWY66snEk2ikqF6fm24CMi5Sn86YWtiLrNRabZRsuLl
x3sGfrk26F4R7EyBpW/ahzCGwQNimEv3yRrXueRovFOzVda9OIfTPLapvuRjg/dZ
XNgrv21rlJROOKQb1PVb/o4n3tkgZ61pjmV1PhA52LfnCmGwlm7vJk8vXGXTn67D
6A3qw83BU1cVotT48CwI
=Pn5J
-----END PGP SIGNATURE-----

--Guq+xBHXhbnAFmh4--
