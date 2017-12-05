Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrhmf4f2wzDrFp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 00:05:06 +1100 (AEDT)
Date: Tue, 5 Dec 2017 13:04:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
Subject: Re: [PATCH 01/10] ASoC: fsl_ssi: Remove unused struct device
Message-ID: <20171205130446.GI11658@finisterre>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
 <1512420403-10164-2-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
In-Reply-To: <1512420403-10164-2-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2017 at 12:46:34PM -0800, Nicolin Chen wrote:
> struct device is defined in system level header files any way.
> As long as fsl_ssi.h is included after those header files, it
> should be safe to remove this line.

It's better practice to either directly include those headers or have a
forward declaration like this, it means there's no way things can go
wrong.

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlommW0ACgkQJNaLcl1U
h9DKngf9G0hdTAKCrt5SUpPnTKgEfzhkb8uVISWw9YmR/iqZcz2Aob1jJKc/J5UB
fP+P+Jk+FTHbUPznEowCL7GJtOiB215wYCbb2aSYMV/Y+Q3RpAPEOijEnbWxR/kh
eIzpxIbF+zWeHLqW5GXEQ9fc3w6uvoP3LzZqBX9rClD/GpRar1JJOvCHFt67pYE7
K6ST4N+L5Hf1xmNtfDboNYQHuhkVYZXv1X3AWK1cajpZSfjuFerau232zc8KpiUT
XO3eh3c/BETO4D74ffsMKIz8QobJPjlM4DNlpzhBiD1/5FBp+YjSn72L21G9JP6f
/vWs3Be/ifI8LPq+R42KSpmfmnMmxw==
=z7pP
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--
