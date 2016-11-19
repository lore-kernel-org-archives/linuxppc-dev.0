Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLTFv4QDxzDvy4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 19:54:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 benh@kernel.crashing.org, hughd@google.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.9-5 tag
Date: Sat, 19 Nov 2016 19:54:53 +1100
Message-ID: <871sy7yhlu.fsf@concordia.ellerman.id.au>
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

The following changes since commit fb479e44a9e240a23c2d208c2ace23542a47f41c:

  powerpc/64s: relocation, register save fixes for system reset interrupt (2016-10-27 21:55:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.9-5

for you to fetch changes up to cac4a185405d4415eca269cae976438b44a37ae0:

  powerpc/mm: Fix missing update of HID register on secondary CPUs (2016-11-18 23:16:58 +1100)

----------------------------------------------------------------
powerpc fixes for 4.9 #5

Fixes marked for stable:
 - Fix system reset interrupt winkle wakeups (Nicholas Piggin)
 - Fix setting of AIL in hypervisor mode (Benjamin Herrenschmidt)

Fixes for code merged this cycle:
 - Fix exception vector build with 2.23 era binutils (Hugh Dickins)
 - Fix missing update of HID register on secondary CPUs (Aneesh Kumar K.V)

Other:
 - Fix missing pr_cont()s in show_stack() (Michael Ellerman)
 - Fix missing pr_cont()s in print_msr_bits() et. al. (Michael Ellerman)
 - Fix missing pr_cont()s in show_regs() (Michael Ellerman)
 - Fix missing pr_cont()s in instruction dump (Andrew Donnellan)
 - Invalidate ERAT on tlbiel for POWER9 DD1 (Michael Neuling)

----------------------------------------------------------------
Andrew Donnellan (1):
      powerpc/oops: Fix missing pr_cont()s in instruction dump

Aneesh Kumar K.V (1):
      powerpc/mm: Fix missing update of HID register on secondary CPUs

Benjamin Herrenschmidt (1):
      powerpc/64: Fix setting of AIL in hypervisor mode

Hugh Dickins (1):
      powerpc: Fix exception vector build with 2.23 era binutils

Michael Ellerman (3):
      powerpc/oops: Fix missing pr_cont()s in show_stack()
      powerpc/oops: Fix missing pr_cont()s in print_msr_bits() et. al.
      powerpc/oops: Fix missing pr_cont()s in show_regs()

Michael Neuling (1):
      powerpc/mm/radix: Invalidate ERAT on tlbiel for POWER9 DD1

Nicholas Piggin (1):
      powerpc/64s: Fix system reset interrupt winkle wakeups

 arch/powerpc/include/asm/exception-64s.h | 15 +++++++++---
 arch/powerpc/include/asm/ppc-opcode.h    |  1 +
 arch/powerpc/kernel/exceptions-64s.S     | 11 ++++++---
 arch/powerpc/kernel/process.c            | 42 ++++++++++++++++----------------
 arch/powerpc/kernel/setup_64.c           | 20 ++++++++++-----
 arch/powerpc/mm/hash_utils_64.c          |  4 +++
 arch/powerpc/mm/pgtable-radix.c          |  4 +++
 arch/powerpc/mm/tlb-radix.c              |  4 +++
 8 files changed, 68 insertions(+), 33 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYMBNeAAoJEFHr6jzI4aWAfp4P/itBPtS7Q0Igrn325knFkPPN
MayfylHbpxzpDwjSPLSxMDxJo0HSnO8SeQYlLqvqL62xMrzThzDw9jg5tZAJ862Q
dctE6An0ubeUnfrAuF1du8/7BlIkURTiY7P9CZ5+m34zycbxREi2MtnaiL0DF637
qOxqBEi2VkMQQ7IuZPsas4fGvSnW/4o9jnc5gEPbE8c1d/nrgi0K2/CnvO2nk9dG
wQ7e0gVBFPFVpzlX7V/glzPvw8ZfNmLpLUpKi6ilrNGCDilyXuSedswyH0/ucE77
vETx6dZKAdBaBf1WcQngXV/XxWFhkH4+G5bX8ef1DHn82doZ/rc335xnCjCvGrbO
taXJED4x7MDwV3EpRGcL4dveeKkrbPs4xa8Dy9ZptK5XC/PaxCny7cZ26G81L0Ji
xSQY83yngf0HGPPfKXJGcH8OmIWn5rAR7f1zmmrL3ZrxpsG3Xp//x0cQGGGoPLhX
YZKacYCYnkQDWr5vGmZ6StWKHHO5x6sAqJRMKV9vTbNz2qG9nROJBn9IOe4yYbDh
AjSaK7VIpeGLsErkPqvtkxObUsaKTCgPNr2pQxCc82gJGb3Q+l7CuNNMGXXEgIvT
5NHy53pBq+lcXlXjDWbCawwR7pbaIUvm7+F4VUc5izgTYuCh2yHB+1/y6E5W0Q6l
Es0+zvZ4Gd35LAh3Sb6a
=+EQR
-----END PGP SIGNATURE-----
--=-=-=--
