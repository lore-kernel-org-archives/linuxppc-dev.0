Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxFFJ1HNvzDqkZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:40:20 +1000 (AEST)
Message-ID: <1461937213.13752.3.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.6-4 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: imunsie@au1.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, rsalvaterra@gmail.com
Date: Fri, 29 Apr 2016 23:40:13 +1000
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-u+/8hJSzgWT50Pazjc9v"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-u+/8hJSzgWT50Pazjc9v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull a few more powerpc fixes for 4.6:

The following changes since commit 4705e02498d6d5a7ab98dfee9595cd5e91db2017=
:

  powerpc: Update TM user feature bits in scan_features() (2016-04-18 20:10=
:45 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.6-4

for you to fetch changes up to d701cca6744fe0d67c86346dcfc9b128b17b5045:

  powerpc: wire up preadv2 and pwritev2 syscalls (2016-04-27 16:47:55 +1000=
)

----------------------------------------------------------------
powerpc fixes for 4.6 #3

 - cxl: Keep IRQ mappings on context teardown from Michael Neuling
 - cxl: Poll for outstanding IRQs when detaching a context from Michael Neu=
ling
 - Wire up preadv2 and pwritev2 syscalls from Rui Salvaterra

----------------------------------------------------------------
Michael Neuling (2):
      cxl: Keep IRQ mappings on context teardown
      cxl: Poll for outstanding IRQs when detaching a context

Rui Salvaterra (1):
      powerpc: wire up preadv2 and pwritev2 syscalls

 arch/powerpc/include/asm/systbl.h      |  2 ++
 arch/powerpc/include/asm/unistd.h      |  2 +-
 arch/powerpc/include/uapi/asm/unistd.h |  2 ++
 drivers/misc/cxl/context.c             |  7 +++++++
 drivers/misc/cxl/cxl.h                 |  2 ++
 drivers/misc/cxl/irq.c                 |  1 -
 drivers/misc/cxl/native.c              | 31 ++++++++++++++++++++++++++++++=
+
 7 files changed, 45 insertions(+), 2 deletions(-)

--=-u+/8hJSzgWT50Pazjc9v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJXI2Q9AAoJEFHr6jzI4aWAj4UP/257dNQdMVXU1hvisr6GgGR4
SvRv2/TVn0Ct58rpOL43xuIoXmazENQrdP+hmyZm/CUXbRWmj7iJLzVNIZ9gJ2zW
LMvmPVtirnb7975B/O91FDgbm+B0XUebAN0FbPvJvGRGEh+c0t99BLe93uXFzLqZ
OqM7GtPR2PAJ9C/Ti0moz6XSCsb2F6gs7XTGv/S/vzULqPS97p5gU8NJWpLYrSC6
gh/qNr9c8uWN3vnMMnLm38/9xuc34csCGOl6bEl/6no1nTFrdnTLl4DdDfxLDuDr
0BKC75Wt120pgHiPBXDpjhkJ+WkRqRR9ztKYlAFOjcGGi5gm9wFSaMOx0jehZVh2
fV9IW2Dnn8Z/XhfGmnlGjLSk5TxA26CQ3kiiwtyW3tlK+O7W4EDdesAPGoqm+foD
TzXAp+mxA7dtSnw/FMoXCzWvkfXGNiZmYskAuW+v2IYrS9u3YShF0dUDlR0NTSCf
zfeGAMPGgkGEz5mzf9u6YwEYSlME6KwRJXjNSL6SnsfP5t3xaPh0pZEvXqFCOmPr
tXfeuKeBXtbISCBs65mBZvjdtIer3sgDe1NYcBx9ce/PDkN8KFqqhFl997BAndCS
ZO3qWlufz3HYAP+KJCaTFU2xAFym5SoxBnuqRpiCspmZEX+EXL81md4EQfaf5zTO
TbikD7M358ISyYwhAUG7
=gtSe
-----END PGP SIGNATURE-----

--=-u+/8hJSzgWT50Pazjc9v--
