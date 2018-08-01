Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gqGS1YmyzF14j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 09:27:28 +1000 (AEST)
Date: Thu, 2 Aug 2018 09:27:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Finn Thain <fthain@telegraphics.com.au>
Subject: linux-next: manual merge of the powerpc tree with the m68k tree
Message-ID: <20180802092708.10e1a71d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EC1hrN=C=vY6p+aOKx0Fx8S"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/EC1hrN=C=vY6p+aOKx0Fx8S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/m68k/mac/misc.c

between commit:

  5b9bfb8ec467 ("m68k: mac: Use time64_t in RTC handling")

from the m68k tree and commit:

  ebd722275f9c ("macintosh/via-pmu: Replace via-pmu68k driver with via-pmu =
driver")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/EC1hrN=C=vY6p+aOKx0Fx8S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltiQdgACgkQAVBC80lX
0GyAswgAigCIeYhR/Or4bRfmuchCPWtOPZTnVo2tMHxqchkY432i2UhwBgtU07B1
gwcS04uA2N9eSxdC3hUjrwIO8lpmVcN7K78plR+gXAAiDdDVu3x6N3JvUP67f7oK
YBp9PjhQt4fxAJFvq7bGTK8OrU6UBhOekIXHB1gizaxlX0KuL9ruqWtY6Z3WKnix
/ovssha1WwahddfE6E5/3LLWL+gFgMWAOlOYoQjkkxRGxn3F7CTuWV46HJR1slu1
wyTYGKk5zX7AD3bliDwJWjEN37YbO5VonG+kz5Pp4Kopfq7p3I7nDStm5l84hceZ
LN+47YmDKXWuNUtW0PXDemjp9sP5dg==
=kELf
-----END PGP SIGNATURE-----

--Sig_/EC1hrN=C=vY6p+aOKx0Fx8S--
