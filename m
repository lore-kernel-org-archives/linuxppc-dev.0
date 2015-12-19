Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DED821A1A1B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Dec 2015 22:11:35 +1100 (AEDT)
Message-ID: <1450523489.14546.5.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.4-5 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alistair@popple.id.au, arnd@arndb.de, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, stewart@linux.vnet.ibm.com,
 sam.bobroff@au1.ibm.com
Date: Sat, 19 Dec 2015 22:11:29 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-De5ro26/pA5FZERiuu/6"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-De5ro26/pA5FZERiuu/6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull what is hopefully the final batch of powerpc fixes for 4.4:

The following changes since commit dc9c41bd9ece090b54eb8f1bbdfb1930e10d3ae7=
:

  Revert "powerpc/eeh: Don't unfreeze PHB PE after reset" (2015-12-09 14:05=
:10 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.4-5

for you to fetch changes up to 036592fbbe753d236402a0ae68148e7c143a0f0e:

  powerpc/opal-irqchip: Fix deadlock introduced by "Fix double endian conve=
rsion" (2015-12-18 22:24:15 +1100)

----------------------------------------------------------------
powerpc fixes for 4.4 #4

 - Partial revert of "powerpc: Individual System V IPC system calls"
 - pr_warn_once on unsupported OPAL_MSG type from Stewart
 - Fix deadlock in opal-irqchip introduced by "Fix double endian conversion=
" from Alistair

----------------------------------------------------------------
Alistair Popple (1):
      powerpc/opal-irqchip: Fix deadlock introduced by "Fix double endian c=
onversion"

Michael Ellerman (1):
      Partial revert of "powerpc: Individual System V IPC system calls"

Stewart Smith (1):
      powerpc/powernv: pr_warn_once on unsupported OPAL_MSG type

 arch/powerpc/include/asm/systbl.h             | 24 ++++++++++++-----------=
-
 arch/powerpc/include/uapi/asm/unistd.h        | 12 ------------
 arch/powerpc/platforms/powernv/opal-irqchip.c | 14 +++++++++++++-
 arch/powerpc/platforms/powernv/opal.c         |  2 +-
 4 files changed, 26 insertions(+), 26 deletions(-)

--=-De5ro26/pA5FZERiuu/6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWdTthAAoJEFHr6jzI4aWAB1MP/jtc0wrHsPo50e6pFqqvhbQy
z4tnYrvYgw9NSydakDWJRYw6vRXRup4awq8s3U5QD7Vx+TX3gI+/4qW7EvOrrgjx
nAGgfKBopptOO6X3zQEcfPbZ9b9RlUxzUlNnxGSiLAG8OFAL4WZDI33zacsDmdPz
wim8+2xHHXZ5GCby8bOli9B1tFklhNdYsacMy9PzdoNbEGWBzdYzOktGSCcU7clU
LCcft14QdOaSx1fLokBiPPgXewBXLxxebhXtk7Yq6kEuh1nq4gA4WLkMABzmhx/V
P9ZjhjhJgMy2ooWTI71fs7HpgChvRbtSOjMCIZ0j1Iiza1elMuBoGqIfGAQ3SW2j
GSPzIGIgr93VUVLqyW4mp9VjRXdBcVoi1obwxoFWm8f9VPKAaY5lsnSrdswMxQOC
zio+/Qz5XwWZDOY91RIIEIqcHxm/pdA6fLUyUeNBv/9jyl3o82ZeIPANgc0our6Z
NNyGuoRFACQO8yYOmSNpqHpvFTfhQuA/GsVLoNFRfK750pupo10swYjFJik3HAc7
HBLB6oBElI7A00H06UOoOzecB7f53V9xseCHpRrKugf+Ad1/KFYyzvI6yW7gpe5Q
RUAbdgn++xQjLFDNTdyx1jHlRXG8vkb/xVOlm4mmkl/jvryC92feiadCIz6Sx3Rb
B9AMPmKpalJqAchUBtV7
=2Zyw
-----END PGP SIGNATURE-----

--=-De5ro26/pA5FZERiuu/6--
