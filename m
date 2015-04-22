Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D29F21A0C10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 05:47:03 +1000 (AEST)
Date: Wed, 22 Apr 2015 20:46:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <20150422194655.GJ22845@sirena.org.uk>
References: <20150422142820.4267B1A242E@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LkBseQZEL/3d2JPd"
In-Reply-To: <20150422142820.4267B1A242E@localhost.localdomain>
Subject: Re: [PATCH v3] spi: fsl-spi: use devm_ioremap_resource() to map
 parameter ram on CPM1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LkBseQZEL/3d2JPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2015 at 04:28:20PM +0200, Christophe Leroy wrote:
> On CPM2, the SPI parameter RAM is dynamically allocated in the
> dualport RAM whereas in CPM1, it is statically allocated to a default
> address with capability to relocate it somewhere else via the use of
> CPM micropatch. The address of the parameter RAM is given by the boot
> loader and expected to be mapped via devm_ioremap_resource()

Applied, thanks.

--LkBseQZEL/3d2JPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN/quAAoJECTWi3JdVIfQ0yQH/2DJ9S8GfJwPwo8ruC+0YONd
SroWJBoDjaXQs8IdvGag/sge4We8f4OAC8gSef3wS/IVp45IHiEH5wzRKiO52Mey
GObMbcLhwX3ASMF5h4wIIV7C4G5sSkam/9awUZghlUNV8m+3dhc1gBmpgYAIwldp
mDv53gkJLt7bC+0vYmIU2Iuyf7z0bEODVuICsuPEes5GRsWCwELnIQ0aOIOq5GAc
kAaV56UV69E2/eXeGpq7O4fcwENe0uDFgt7dzzQK8lXO0GYbTk/c8+nY1oCA2Hsk
pj18A+AsFnKbaNpSMvNB4B05mi9gAyZqaMR7KQfty9BJX0oM1f4iKW+g+wj8RwE=
=Yt/f
-----END PGP SIGNATURE-----

--LkBseQZEL/3d2JPd--
