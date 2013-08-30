Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 853022C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Aug 2013 08:01:41 +1000 (EST)
Date: Fri, 30 Aug 2013 23:01:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <b42378@freescale.com>
Message-ID: <20130830220133.GB18608@sirena.org.uk>
References: <7c26687b556e1b4fc33ea5771de7b64e45a02d38.1377855239.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
In-Reply-To: <7c26687b556e1b4fc33ea5771de7b64e45a02d38.1377855239.git.b42378@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: fsl: Add wrapping for dev_dbg() in fsl_spdif.c
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 30, 2013 at 05:38:08PM +0800, Nicolin Chen wrote:
> Add wrapping '\n' for dev_dbg() in fsl_spdif.c

Applied both, thanks.

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSIRY6AAoJELSic+t+oim9cYMP/0NaYZIyebC4kqYozti3BkOq
Bx/mPLgZmmvjbFb0a6CQ1FNQfaFVt+xz+ubHmA508ebcHOoBNu7DMmK/gU6qKJcU
LUMMpY953bS4lhfpYlonIFVukBkjyyC+srZPwsZG6/lw1s1r5w//Pp0Un6d6h5fa
kIfh9NdiG5xEk56gy5D4vIjIF8C1AlEq0mjyaBI/gkqp3pMirLWio0QsdDQdPFu0
VtGrOY9N4Ii40Y39zV0DNiVi+PQI5QGEn2ClicNHT670DZwwdYRsQUkuzR1y9eQj
KUIMfWBMNF/fDY6QN5jetqmCZMcGQZOexUNjx0v62aSvcCm4EjPL5ixEwKI0EBjw
UH/ExUjnhQsNRHCYmWmepbk8RFUdGjFVVVd4aGxqAhw2N7mpAIyAwAgpU0hcZUn0
X2Q7O2e0RuIDp7BnN6fYBzHWvwnBRnuJpeqlaWvs4ZAwOm24URiCgljgJr1g7CIK
9CO5eMvy+POKtKpxX5ociwWyjdTvdD8eresWsHvSEW13deMX+ELDC+flYNO61IO8
uY2bQdN/QRvXKfoGNiLarx85EMlhQpprT18vgWYJ41gcOQT56Hfh/28/bIeOn3mk
PqDARa0Rk/zbP051sg4WrNgTx/+5+1iqYN9ThMmTSLRSUQM7ijZ94pUkYWGjbQGK
c8exp8heG1OojqNx/iJO
=CXoi
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
