Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 153081A0EF5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 13:40:46 +1000 (AEST)
Date: Thu, 11 Jun 2015 13:40:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Geoff Levand
 <geoff@infradead.org>
Subject: linux-next: manual merge of the block tree with the powerpc-mpe tree
Message-ID: <20150611134041.55e69982@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uFZiafKl+6O2ae/xyl_09jo"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/uFZiafKl+6O2ae/xyl_09jo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Today's linux-next merge of the block tree got a conflict in
MAINTAINERS between commit a14ab6b6e0ad ("powerpc/cell: Drop
cbe-oss-dev mailing list from MAINTAINERS") from the powerpc-mpe tree
and commit 3715a5d014e1 ("MAINTAINERS: Update ps3vram block driver")
from the block tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc MAINTAINERS
index b09702c197ca,b327ac39e951..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -8018,7 -7853,9 +8019,8 @@@ F:	sound/ppc/snd_ps3
 =20
  PS3VRAM DRIVER
  M:	Jim Paris <jim@jtan.com>
+ M:	Geoff Levand <geoff@infradead.org>
  L:	linuxppc-dev@lists.ozlabs.org
 -L:	cbe-oss-dev@lists.ozlabs.org
  S:	Maintained
  F:	drivers/block/ps3vram.c
 =20

--Sig_/uFZiafKl+6O2ae/xyl_09jo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVeQM9AAoJEMDTa8Ir7ZwVUhAP/0IonOGhgToHgkoL8zaOzB/s
aLAiQJUGQUbRQ8kgEXTFgqcZ5/UYnuQGqJ7bg7l0numNY1n71dbXZuJFI979BfpY
6UZHlLD2CiVeZ0sEEf3UH6Z0dQ1wAq9K5k2hR1c8hYVtDpG51VjP10OtnK+fh31b
8Td5NuIoCyGGoPppmlWgkqjMBV82U4fnnoM3elwbqjlNAwzuTBku5LcjbO8E0ejS
ARQovyAk+qez5yf4z2m4GfkSGAJahs4d334UGZrO5pTPObPgpbQbon6RTvobZNUw
kvCuVYl3c9RJ7QZ2zxKUXL5EGahGMWBtMj92OfkZ9QSWfoY6/I4mREfovC4BKNg3
ArsWXpQjJo/RXsNzzEP4ovO/+8cBeQnrYVhfH/xaUVSZ7P+v1hcq0rlsmkzqHl5k
rLkmOrMunUW9wQ7RJpVxr5U+d8o3arJL6/5zRsT/jVVB51sNM9pYNP9Uq0w+JFA+
Cx1HT1mMqKtUys+e1alW54PO9d+QHKzAyv3uBS7UYkPpNUgaFDBjbFRwJGvm4o9P
HyR6IRmToqFyxKw+xY5DeQIteAIhUoE59WtFvRUrFyuKs4bM60P+eamCbozzyu1Y
tioCiKLL3qe/70FDeV9S3ocfQXTu/ukp5krNEn6123+F1TOr2D7vurLYl0R57nbO
p1Kaj6DOaj+hDpVY6g3R
=0kU7
-----END PGP SIGNATURE-----

--Sig_/uFZiafKl+6O2ae/xyl_09jo--
