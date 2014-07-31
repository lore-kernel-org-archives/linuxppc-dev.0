Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48C051A002C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 05:24:28 +1000 (EST)
Date: Thu, 31 Jul 2014 20:24:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20140731192402.GL17528@sirena.org.uk>
References: <20140731093209.GF30276@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1km+XC/p/ep4c9cZ"
In-Reply-To: <20140731093209.GF30276@mwanda>
Subject: Re: [patch -next] ASoC: fsl_asrc: fix an error code in
 fsl_asrc_probe()
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org,
 Timur Tabi <timur@tabi.org>, Jaroslav Kysela <perex@perex.cz>,
 Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--1km+XC/p/ep4c9cZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 31, 2014 at 12:32:09PM +0300, Dan Carpenter wrote:
> There is a cut and paste bug so it returns success instead of the error
> code.

Applied, thanks.  Might be worth looking at how you're generating your
CC lists here, it seems a bit random.

--1km+XC/p/ep4c9cZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2pfPAAoJELSic+t+oim9dEUQAIWxQhqoVk38JF6Z0yvVc8+O
B+zV4AYxzjY+9gLpGY7uDI/Dmdw06RpbuYfrk3t2o/kd7/XdfQiq7tr7h/ea6aFA
lIvmqovviaWyJR3SaeNa0agwN9Tb6YRAoRboVfoZ0nDVLryaKoeyWWG0jcygzliG
w7BQyOL5KEDbL0aRdn1cqA2t7R5eyHMj8H0N4K+K8y7PmvGAr+n0FfUhbXzwL5ht
rULwprgHW3ArYSrOSsVrkkGRuQqnfUXoTIpd+ebgIqxGrvmyQxIY61wkgmrU80Nr
es2iUdkI3/dWrvMfL1oKwt4PKa1OPi/BhOPaVhQFlNKg2B/EjmxaCGqQNgbJY9sK
7gOVWgP2YzIfmrCiwsm0y9+2RJAGs2pI1D9MI3ttsrLxyxIXvetGu3brCEZMtosh
Bb3mmXFk+uMChjCgcBMpBJtu7CmjrkzbTQkWZ281r2aGNmgDvPbgbgWwvG4rmat/
BhbPAOtlDpLk6TNtdcd3zH3WKWEQo0S5bBCefLJfLTAohXNyXXZCtKtw3IBJamJd
QwOBKIxSUdV8KP7Nf5Fnya1ej/s+Rodf7/iKZsfc36AlOm31B7O24frsjS8q1B/d
1IHMewZV1u7SzQlv5LqWVTk63Fg3PiFe7ahUQR8+2AGJ9aea9/FAHcQD8i+asjI7
iU/SnumU7/Ol39WptEPQ
=PNDi
-----END PGP SIGNATURE-----

--1km+XC/p/ep4c9cZ--
