Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wZd4z53kNzDqP0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 May 2017 19:29:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alistair@popple.id.au, benh@kernel.crashing.org, jk@ozlabs.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.12-4 tag
Date: Sat, 27 May 2017 19:29:52 +1000
Message-ID: <878tli8x67.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc fixes for 4.12:

The following changes since commit e41e53cd4fe331d0d1f06f8e4ed7e2cc63ee2c34:

  powerpc/mm: Fix virt_addr_valid() etc. on 64-bit hash (2017-05-19 13:04:35 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.12-4

for you to fetch changes up to a4700a26107241cc7b9ac8528b2c6714ff99983d:

  powerpc: Add PPC_FEATURE userspace bits for SCV and DARN instructions (2017-05-25 23:07:45 +1000)

----------------------------------------------------------------
powerpc fixes for 4.12 #4

Fix running SPU programs on Cell, and a few other minor fixes.

Thanks to:
  Alistair Popple, Jeremy Kerr, Michael Neuling, Nicholas Piggin.

----------------------------------------------------------------
Alistair Popple (1):
      powerpc/powernv/npu-dma.c: Fix opal_npu_destroy_context() call

Jeremy Kerr (1):
      powerpc/spufs: Fix hash faults for kernel regions

Michael Ellerman (1):
      selftests/powerpc: Fix TM resched DSCR test with some compilers

Michael Neuling (1):
      powerpc: Fix booting P9 hash with CONFIG_PPC_RADIX_MMU=N

Nicholas Piggin (1):
      powerpc: Add PPC_FEATURE userspace bits for SCV and DARN instructions

 arch/powerpc/include/uapi/asm/cputable.h             | 2 ++
 arch/powerpc/kernel/cputable.c                       | 3 ++-
 arch/powerpc/kernel/prom.c                           | 2 ++
 arch/powerpc/platforms/cell/spu_base.c               | 4 +++-
 arch/powerpc/platforms/powernv/npu-dma.c             | 5 ++---
 tools/testing/selftests/powerpc/tm/tm-resched-dscr.c | 2 +-
 6 files changed, 12 insertions(+), 6 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZKUcRAAoJEFHr6jzI4aWANe8P/RUrmdYm8haOsUkIZx/ZfOlM
yqdMU2sZal/tJMdW9jVGRMOUcGhY9q+QwqqIAfz93PZvAyfdzHbCaOLEgxwivfmE
9IKspkGJ4jeUZ5d08rudTsPXblFbJEBH6WE6xbaD7BwYnNb17A19tZC1FjRhz/tf
+QvRTN4UgfhgYfeejkkjJLjmVMlbD+9Tk8EhSGGDivgGASV0WEd2nFxJUnhSJlPm
tOhh1wLkeXU3xz6UgCteK3gCl/zHQRAPVIT4IFRR+pA0qV8ecp+diDEe/6kxNjqb
AAuRgxw0kEAPjKnmfgkNb19C0VIxVIeG41+3nQeWLgqD/tnJCek/4BRjKSgxfdtx
k6tXAPRJLzrR/wDY9RiqcHLWgAHRVnwHPJY2b7UzTsG7XuViIZKst4R2+tmp2Nbz
CUyLDMlQQ32/pAI9m6rgwKB/G0g8GRWNIcjfMLndm14xD9R0/dZ1uOZCyWkUH/g7
eMScHimZD62r8Z/nV8bHccJC/AZ8PGaia/EgRfeQ6VM55nzwalwa9paANPELSOVb
G5D0cvVkCPCTnvTuRf2Hx5A8hj21SlLuKTtU/nEV0iOhZdueugLqc8OXaVfO6HHH
P8xDT7sXltGL9rNO4rS1F187plgrID2Z4ItGlIZgI9IFRG5fkx/KZ7nmHPJSdgJz
OKaYQqiw4ovliu6MKGiM
=nizS
-----END PGP SIGNATURE-----
--=-=-=--
