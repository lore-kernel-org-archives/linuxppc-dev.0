Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQlz507pqzDvnv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 19:12:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 oohall@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.9-6 tag
Date: Sat, 26 Nov 2016 19:11:59 +1100
Message-ID: <87inraslrk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Hi Linus,

Please pull some more powerpc fixes for 4.9:

The following changes since commit cac4a185405d4415eca269cae976438b44a37ae0:

  powerpc/mm: Fix missing update of HID register on secondary CPUs (2016-11-18 23:16:58 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git powerpc-4.9-6

for you to fetch changes up to 984d7a1ec67ce3a46324fa4bcb4c745bbc266cf2:

  powerpc/mm: Fixup kernel read only mapping (2016-11-25 14:18:25 +1100)

----------------------------------------------------------------
powerpc fixes for 4.9 #6

Fixes marked for stable:
 - Set missing wakeup bit in LPCR on POWER9 (Benjamin Herrenschmidt)
 - Fix the early OPAL console wrappers (Oliver O'Halloran)
 - Fixup kernel read only mapping (Aneesh Kumar K.V)

Fixes for code merged this cycle:
 - Fix missing CRCs, add more asm-prototypes.h declarations (Nicholas Piggin)

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/mm: Fixup kernel read only mapping

Benjamin Herrenschmidt (1):
      powerpc: Set missing wakeup bit in LPCR on POWER9

Nicholas Piggin (1):
      powerpc: Fix missing CRCs, add more asm-prototypes.h declarations

Oliver O'Halloran (1):
      powerpc/boot: Fix the early OPAL console wrappers

 arch/powerpc/boot/main.c                  |  8 ++++++--
 arch/powerpc/boot/opal-calls.S            | 13 +++++++++++++
 arch/powerpc/boot/opal.c                  | 11 +++++++++++
 arch/powerpc/boot/ops.h                   |  1 +
 arch/powerpc/include/asm/asm-prototypes.h | 12 ++++++++++++
 arch/powerpc/include/asm/mmu.h            | 14 ++++++++++----
 arch/powerpc/include/asm/reg.h            |  1 +
 arch/powerpc/kernel/cpu_setup_power.S     |  8 ++++----
 arch/powerpc/mm/hash_utils_64.c           |  8 ++++++--
 9 files changed, 64 insertions(+), 12 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYOUPPAAoJEFHr6jzI4aWA1OYP/0Av4YYpA54e9lxE5wmzJHH+
kDGCz2zRRHYePF2gOS/Ia+01YlCXDJO8ZxavPIyTPkUiSmDgL+CtltKY77HGgmha
xTYrkhlUWP9pbeP5R+4432d0YeZNbJbWJv5kz4FsaGMl+M/sjP2o06/RdDjquaI/
lZHbzMuR3aE0t8X9Yjbw4gRQnMgN9A8F7wOnXvDJkZ+WKPDw5egJ/3JHIWPFN4sk
432xbmGn2CUZ26dGz0rualUvKM/j22wGBnJJbwM/+Pr24oG9Id2rD7Kb2hMVUg6G
n+DkusQ+Q28BSHjSXHdMDskyCdeWfdp4K9ViyPmiAhtk3GU3VzkfaBo72/gQ3hJf
tZ5VlgEt8+dH2vrKOryRh88Swm1iixQEYZ1wq8vNyj77Jp+QhPmWJE0lFm8kOIMH
vNVKLOgXNEycctWasjV5R4w6EwR1tzNKJfaL7zyKsan33zCHWeUgY48sySLVny11
TWSRxNxaeahdbEAA63/n2rPiHqEfaRjfUZWhtyw9bthDhzF6hwbpP/YNFOW59S49
kCFv7Q6iwvxUUGJfYGdl6uzcS26tc/EIVFB2o7Zu3LsvFyP8C1uF4tqrIwmhEkb9
OtMH9xe0vWLeRCIw6OSE5uaPXIt1M5VVD5UptWhObrI0IcyDby6OANwm4zrwKpTV
eNotpZL/kP9q/eKOTHyL
=oEFS
-----END PGP SIGNATURE-----
--=-=-=--
