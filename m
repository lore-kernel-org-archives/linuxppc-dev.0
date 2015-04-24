Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412491A0C2F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 22:38:36 +1000 (AEST)
Date: Fri, 24 Apr 2015 13:38:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <20150424123826.GP22845@sirena.org.uk>
References: <20150423121147.AFEA31A2439@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="477QOTsP+opw3g0q"
In-Reply-To: <20150423121147.AFEA31A2439@localhost.localdomain>
Subject: Re: [PATCH] spi: fsl-spi: fix devm_ioremap_resource() error case
Cc: jogo@openwrt.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--477QOTsP+opw3g0q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2015 at 02:11:47PM +0200, Christophe Leroy wrote:
> devm_ioremap_resource() doesn't return NULL but an ERR_PTR on error.

Applied, thanks.

--477QOTsP+opw3g0q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOjlCAAoJECTWi3JdVIfQ7fAH/iQdoHinfc/AEHeKe+LNKid4
pWTzbgxOl5ickly0B6s1KqERvcaSuU2nLqfk1m3P1WRw5MlUmM0ZkPZd9SWkP6jq
rqWxKsXMRuaItgbv7ftHFB3GeLVFDwm32LZjwj3ONKzoUmSZvNfFgCAU8ijgAVsy
+uPUCFMh+YgJMHQMCzffiuhhNdAgcZ1I9YUb48aO1E3wQdRkPizgcjgVXr3dPDmB
mG0HvboOe+xSwkJcg2k0BaxZuPwPfykDdQSEJUvR/0CibvUigZwe7/1wnBIJx+ei
O4tmPhGQPlIMlKODcPCOqz7HtURmw5HYNtqM7qFWIAcgIWNwfn9zNEZ6wG2bruI=
=gRmh
-----END PGP SIGNATURE-----

--477QOTsP+opw3g0q--
