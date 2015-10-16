Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E2E81A0912
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 21:37:49 +1100 (AEDT)
Message-ID: <1444991868.12954.6.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.3-4 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: andrew.donnellan@au1.ibm.com, clombard@linux.vnet.ibm.com,
 cyrilbur@gmail.com, dja@axtens.net, felix@linux.vnet.ibm.com,
 imunsie@au1.ibm.com,  linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 16 Oct 2015 21:37:48 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-8QNbngEI2/ha+CYJoqPU"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-8QNbngEI2/ha+CYJoqPU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull some more powerpc fixes for 4.3:

The following changes since commit 9ffecb10283508260936b96022d4ee43a7798b4c=
:

  Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.3-4

for you to fetch changes up to abb39bc792aa8e9143e78a39ec13d7de1391f4b4:

  selftests/powerpc: Fix build failure of load_unaligned_zeropad test (2015=
-10-13 15:08:37 +1100)

----------------------------------------------------------------
powerpc fixes for 4.3 #3

 - Re-enable CONFIG_SCSI_DH in our defconfigs
 - Remove unused os_area_db_id_video_mode
 - cxl: fix leak of IRQ names in cxl_free_afu_irqs() from Andrew
 - cxl: fix leak of ctx->irq_bitmap when releasing context via kernel API f=
rom Andrew
 - cxl: fix leak of ctx->mapping when releasing kernel API contexts from An=
drew
 - cxl: Workaround malformed pcie packets on some cards from Philippe
 - cxl: Fix number of allocated pages in SPA from Christophe Lombard
 - Fix checkstop in native_hpte_clear() with lockdep from Cyril
 - Panic on unhandled Machine Check on powernv from Daniel
 - selftests/powerpc: Fix build failure of load_unaligned_zeropad test

----------------------------------------------------------------
Andrew Donnellan (3):
      cxl: fix leak of IRQ names in cxl_free_afu_irqs()
      cxl: fix leak of ctx->irq_bitmap when releasing context via kernel AP=
I
      cxl: fix leak of ctx->mapping when releasing kernel API contexts

Christophe Lombard (1):
      cxl: Fix number of allocated pages in SPA

Cyril Bur (1):
      powerpc: Fix checkstop in native_hpte_clear() with lockdep

Daniel Axtens (1):
      powerpc/powernv: Panic on unhandled Machine Check

Michael Ellerman (3):
      powerpc/configs: Re-enable CONFIG_SCSI_DH
      powerpc/ps3: Remove unused os_area_db_id_video_mode
      selftests/powerpc: Fix build failure of load_unaligned_zeropad test

Philippe Bergheaud (1):
      cxl: Workaround malformed pcie packets on some cards

 arch/powerpc/configs/ppc64_defconfig               |  2 +-
 arch/powerpc/configs/pseries_defconfig             |  2 +-
 arch/powerpc/include/asm/machdep.h                 |  9 +++++--
 arch/powerpc/mm/hash_native_64.c                   | 23 +++++++++---------
 arch/powerpc/platforms/powernv/opal.c              |  7 ++++--
 arch/powerpc/platforms/ps3/os-area.c               |  5 ----
 drivers/misc/cxl/api.c                             |  1 +
 drivers/misc/cxl/context.c                         |  3 +++
 drivers/misc/cxl/cxl.h                             |  1 +
 drivers/misc/cxl/file.c                            | 13 +++++++---
 drivers/misc/cxl/irq.c                             |  4 +---
 drivers/misc/cxl/native.c                          |  2 +-
 drivers/misc/cxl/pci.c                             | 28 ++++++++++++++++++=
++++
 .../powerpc/primitives/load_unaligned_zeropad.c    |  9 +++++++
 14 files changed, 79 insertions(+), 30 deletions(-)

--=-8QNbngEI2/ha+CYJoqPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWINN8AAoJEFHr6jzI4aWA9uQP/jtNb4dvT3M7RFhqI2SHmAtz
Pi6TBXx6ql6j3K1dLmK4W/emy0ejorgW2hkc1zDFuY4d3dWxqk+7hcTbFCt2Fndu
Y0R/E5W5ubYeZ9zV6oXB3rCSJfgBgBEPsEToITlOyKz12MZlsODe7VbKDBTll0P1
CaRMMqXevwmZCF4svR9G3CbreC+3ThlxbbRO+6L35uFhEJTmbLGgCFHbL3LNkFPN
SSz5i/CQisRlxkS4uVEAvg7q2A5Wt9dCDXP1UC/Dea86/UcPo2UNIGcbPb/fDu8O
ICFYMKhs6BJT7seT1KIiAeTH2PyEEOZDsHOG9Brj9QTX7RZ0uy5KXYlxna40J8F1
Mh061vau7CvcEAgCyvRWzo3HYolxZwiSJAD4eZgzfPhYPK/5TTzgaLIHt89jbQ3o
tBzQpnTOPlNalobwvstRSSShbqqfclsrgoCWa3f99TBSp3Gs6xhkfAVEIQGdZ1q3
DiZM7jKYuIXpg9JBgKf4DjCyYF6O1KU6M3Km2ThUdzRT3DnRVtRKXG3N87hlYaQI
5q/6LZQRd+dzPRRdEbO50IBV9p44cSG5mK88IdMkPP9HswYGAEAQ5TBLDFl8y5H8
bmRSxSHKJHl7DA7RYLWDp5ZJDjms9spGva4fRwIMtUsD9CWFk/eR1WunYni62XRH
bkrCyCDyXGu++B0s09oT
=kqg9
-----END PGP SIGNATURE-----

--=-8QNbngEI2/ha+CYJoqPU--
