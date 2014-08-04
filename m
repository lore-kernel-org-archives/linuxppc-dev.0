Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 577501A0148
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 00:50:31 +1000 (EST)
Date: Mon, 4 Aug 2014 15:48:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20140804144857.GS30458@sirena.org.uk>
References: <cover.1407125653.git.nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cLlE6j+44ygFdGhU"
In-Reply-To: <cover.1407125653.git.nicoleotsuka@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: fsl_asrc: Fix two dereferenced variable before
 check
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--cLlE6j+44ygFdGhU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 04, 2014 at 12:19:47PM +0800, Nicolin Chen wrote:
> These two patches fixes two warning of dereferenced variable reported by
> Dan Carpenter <dan.carpenter@oracle.com>

Applied both, thanks.

--cLlE6j+44ygFdGhU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT351WAAoJELSic+t+oim9NToQAJUF1XjbsAlLJBtudz22BZB4
pT0zwdKzezTIWkiCRqJA6WLcI2uotofSUEOyj+Oyp1/DfcS1/1GPPGKRV5g/sZn8
lKJAQhD7K+dJXqVgYcjz42DhTGZq55Drva9T+tA6aP4745GYsYqOWnTDZONNBB3d
rbIPUgXCiL47Kwnn/dHSQLsFEzwUdiQc2cOBzBlykim5k1eQWefhZp8Kw85wN+ea
cNg3T8eWNP/FFbVxF7l/des/7KY6y3QAm5wRNFPDSOOhcoN87OhYmmeZpoDl7WqO
Kc1pxGjKY8EOMd6nZSC3uID5vqQwuBRHWU42I0VAHO7/HLAJSGPYIzOBTsYDUNnB
vD0z0HnWa7kWnuqVi7pAc0y9v37Am/xSZn8L3L9Fga3SQxPvxMtxDxZNP2uqJFEY
9pqLigIw/aXSFm6fjVK98ZJgbMNU8+sFjhtKfjdU5UXZQ8cNaHT9GlJwlrroXmPF
ruyI0WDklicdatlInhbs3WjyiHCWX+Awr0ZDmeRVd9cEzhY22SEDIqd0HZK/gu6+
g1th0bZrPjSMb7Eofdl4gOoeyEhv3HQH9Dtwd6VxnySaTj4YzFYldtHELiyNQFpH
PIwcAp2eyOAdVWTARiH6jUXO5M9sLuo12YmMenuByvq7QrbRyEzgvSpkjULI/X1H
p5iIxT6ioswgvNtQnXuM
=22xm
-----END PGP SIGNATURE-----

--cLlE6j+44ygFdGhU--
