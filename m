Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVwlG4xp2zDrpW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 22:00:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bauerman@linux.vnet.ibm.com, benh@kernel.crashing.org,
 christophe.leroy@c-s.fr, gwshan@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.8-5 tag
Date: Fri, 09 Sep 2016 22:00:56 +1000
Message-ID: <87vay5jn9j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull some more powerpc fixes for 4.8:

The following changes since commit 78a3e8889b4b6b99775ed954696ff3e017f5d19b:

  powerpc: signals: Discard transaction state from signal frames (2016-08-29 12:48:40 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.8-5

for you to fetch changes up to f077aaf0754bcba0fffdbd925bc12f09cd1e38aa:

  powerpc/mm: Don't alias user region to other regions below PAGE_OFFSET (2016-09-08 13:15:33 +1000)

- ----------------------------------------------------------------
powerpc fixes for 4.8 #5

 - Don't alias user region to other regions below PAGE_OFFSET from Paul Mackerras
 - Fix again csum_partial_copy_generic() on 32-bit from Christophe Leroy
 - Fix corrupted PE allocation bitmap on releasing PE from Gavin Shan

Fixes for code merged this cycle:
 - Fix crash on releasing compound PE from Gavin Shan
 - Fix processor numbers in OPAL ICP from Benjamin Herrenschmidt
 - Fix little endian build with CONFIG_KEXEC=n from Thiago Jung Bauermann

- ----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      powerpc/xics/opal: Fix processor numbers in OPAL ICP

Christophe Leroy (1):
      powerpc/32: Fix again csum_partial_copy_generic()

Gavin Shan (2):
      powerpc/powernv: Fix crash on releasing compound PE
      powerpc/powernv: Fix corrupted PE allocation bitmap on releasing PE

Paul Mackerras (1):
      powerpc/mm: Don't alias user region to other regions below PAGE_OFFSET

Thiago Jung Bauermann (1):
      powerpc/pseries: Fix little endian build with CONFIG_KEXEC=n

 arch/powerpc/lib/checksum_32.S            |  7 ++++---
 arch/powerpc/mm/slb_low.S                 |  7 ++++++-
 arch/powerpc/platforms/powernv/pci-ioda.c | 18 +++++++++++-------
 arch/powerpc/platforms/pseries/setup.c    |  2 +-
 arch/powerpc/sysdev/xics/icp-opal.c       | 12 +++++++-----
 5 files changed, 29 insertions(+), 17 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX0qR5AAoJEFHr6jzI4aWAVPEP/3LT7pd7CrUP3y1EiFUQOuxp
FSEUevJh8v9Ib5/89FXztad4NjD+OX7NMIcjhjsJAY0EESHf9a44jT8MsOxbkyGg
+bqGlmhtkJtf80KagpCqwDpOzQItYxNdtKPhgekHjAb+GnVgd2R6BfmCFMTzygI5
eWc7iBK9CnAdzzAyIo2SZs53p892unwp8tvMtVf0rmz3WP476eqBPw9RSwp75pzP
59IRfjzKPqe0vDfV0pv8+y+/CTxG5a3D9DX5/agrSzFIKG/fJRjDRL2jaFR9T6OZ
V9DLnH5jkmhtmW9Py84vOT/h4WPMXy6/GvBBLPc7w6txKbwpkbvdb2AqpFadIrb0
DenjlhK41X3MRMHp0mLY0p/M1f4Bf/Vdtll6anXiD7bpdDXdpeyXOdDhFO43EGGz
A1tQJjKTa3iTM8dW/0FcBjmkZOAJ64h+Sin85TH45StFxueC3Lym05PyOEYx6Ds8
I+AFIhO4WDlHacNm0ZrQXr+BDsZknaKcVsAL+rJ5fNmgaJHWFu35gktqh7rY66Sg
8Me3WCBWViuR/0kSoUdmg+axyUGGgVGlSOqcbXkoispL4m12yWCA6FpYz3szn4dv
i62iYNK0n/JQU0wWCB9+PGOOl15KZAEIXVI6e8crYeM0Ow+51i0+JbvJNG1DAAOB
A49WKLc3wGOONnBQJtYv
=u6YP
-----END PGP SIGNATURE-----
