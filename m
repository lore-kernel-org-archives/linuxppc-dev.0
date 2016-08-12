Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9fYH1QpFzDr21
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 19:22:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds  <torvalds@linux-foundation.org>
Cc: aik@ozlabs.ru, alastair@d-silva.org, andrew.donnellan@au1.ibm.com,
 anton@samba.org, arnd@arndb.de, benh@kernel.crashing.org,
 christophe.leroy@c-s.fr, cyrilbur@gmail.com, dan.carpenter@oracle.com,
 darren@stevens-zone.net, fbarrat@linux.vnet.ibm.com, felix@linux.vnet.ibm.com,
 gpiccoli@linux.vnet.ibm.com, imunsie@au1.ibm.com, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, linuxppc-dev@lists.ozlabs.org, mahesh@linux.vnet.ibm.com,
 npiggin@gmail.com, svaidy@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.8-3 tag
Date: Fri, 12 Aug 2016 19:22:24 +1000
Message-ID: <87bn0ytk8f.fsf@concordia.ellerman.id.au>
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

Please pull some powerpc fixes for 4.8:

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.8-3

for you to fetch changes up to ca49e64f0cb1368fc666a53b16b45d4505763d9c:

  selftests/powerpc: Specify we expect to build with std=gnu99 (2016-08-10 23:21:37 +1000)

----------------------------------------------------------------
powerpc fixes for 4.8 #3

 - powerpc/vdso: Fix build rules to rebuild vdsos correctly from Nicholas Piggin
 - powerpc/ptrace: Fix coredump since ptrace TM changes from Cyril Bur
 - powerpc/32: Fix csum_partial_copy_generic() from Christophe Leroy
 - cxl: Set psl_fir_cntl to production environment value from Frederic Barrat
 - powerpc/eeh: Switch to conventional PCI address output in EEH log from Guilherme G. Piccoli
 - cxl: Use fixed width predefined types in data structure. from Philippe Bergheaud
 - powerpc/vdso: Add missing include file from Guenter Roeck
 - powerpc: Fix unused function warning 'lmb_to_memblock' from Alastair D'Silva
 - powerpc/powernv/ioda: Fix TCE invalidate to work in real mode again from Alexey Kardashevskiy
 - powerpc/cell: Add missing error code in spufs_mkgang() from Dan Carpenter
 - crypto: crc32c-vpmsum - Convert to CPU feature based module autoloading from Anton Blanchard
 - powerpc/pasemi: Fix coherent_dma_mask for dma engine from Darren Stevens

Benjamin Herrenschmidt:
 - powerpc/32: Fix crash during static key init
 - powerpc: Update obsolete comment in setup_32.c about early_init()
 - powerpc: Print the kernel load address at the end of prom_init()
 - powerpc/pnv/pci: Fix incorrect PE reservation attempt on some 64-bit BARs
 - powerpc/xics: Properly set Edge/Level type and enable resend

Mahesh Salgaonkar:
 - powerpc/book3s: Fix MCE console messages for unrecoverable MCE.
 - powerpc/powernv: Fix MCE handler to avoid trashing CR0/CR1 registers.
 - powerpc/powernv: Move IDLE_STATE_ENTER_SEQ macro to cpuidle.h
 - powerpc/powernv: Load correct TOC pointer while waking up from winkle.

Andrew Donnellan:
 - cxl: Fix sparse warnings
 - cxl: Fix NULL dereference in cxl_context_init() on PowerVM guests

Michael Ellerman:
 - selftests/powerpc: Specify we expect to build with std=gnu99
 - powerpc/Makefile: Use cflags-y/aflags-y for setting endian options
 - powerpc/pci: Fix endian bug in fixed PHB numbering

----------------------------------------------------------------
Alastair D'Silva (1):
      powerpc: Fix unused function warning 'lmb_to_memblock'

Alexey Kardashevskiy (1):
      powerpc/powernv/ioda: Fix TCE invalidate to work in real mode again

Andrew Donnellan (2):
      cxl: Fix NULL dereference in cxl_context_init() on PowerVM guests
      cxl: Fix sparse warnings

Anton Blanchard (1):
      crypto: crc32c-vpmsum - Convert to CPU feature based module autoloading

Benjamin Herrenschmidt (5):
      powerpc/xics: Properly set Edge/Level type and enable resend
      powerpc/pnv/pci: Fix incorrect PE reservation attempt on some 64-bit BARs
      powerpc: Print the kernel load address at the end of prom_init()
      powerpc: Update obsolete comment in setup_32.c about early_init()
      powerpc/32: Fix crash during static key init

Christophe Leroy (1):
      powerpc/32: Fix csum_partial_copy_generic()

Cyril Bur (1):
      powerpc/ptrace: Fix coredump since ptrace TM changes

Dan Carpenter (1):
      powerpc/cell: Add missing error code in spufs_mkgang()

Darren Stevens (1):
      powerpc/pasemi: Fix coherent_dma_mask for dma engine

Frederic Barrat (1):
      cxl: Set psl_fir_cntl to production environment value

Guenter Roeck (1):
      powerpc/vdso: Add missing include file

Guilherme G. Piccoli (1):
      powerpc/eeh: Switch to conventional PCI address output in EEH log

Mahesh Salgaonkar (4):
      powerpc/powernv: Load correct TOC pointer while waking up from winkle.
      powerpc/powernv: Move IDLE_STATE_ENTER_SEQ macro to cpuidle.h
      powerpc/powernv: Fix MCE handler to avoid trashing CR0/CR1 registers.
      powerpc/book3s: Fix MCE console messages for unrecoverable MCE.

Michael Ellerman (3):
      powerpc/pci: Fix endian bug in fixed PHB numbering
      powerpc/Makefile: Use cflags-y/aflags-y for setting endian options
      selftests/powerpc: Specify we expect to build with std=gnu99

Nicholas Piggin (1):
      powerpc/vdso: Fix build rules to rebuild vdsos correctly

Philippe Bergheaud (1):
      cxl: Use fixed width predefined types in data structure.

 arch/powerpc/Makefile                           | 22 ++++----
 arch/powerpc/crypto/crc32c-vpmsum_glue.c        |  3 +-
 arch/powerpc/include/asm/cpuidle.h              | 13 +++++
 arch/powerpc/include/asm/feature-fixups.h       |  1 +
 arch/powerpc/include/asm/switch_to.h            |  8 ---
 arch/powerpc/include/asm/xics.h                 |  2 +
 arch/powerpc/kernel/eeh.c                       |  4 +-
 arch/powerpc/kernel/exceptions-64s.S            | 69 ++++++++++++++-----------
 arch/powerpc/kernel/idle_book3s.S               | 17 ++----
 arch/powerpc/kernel/mce.c                       |  3 +-
 arch/powerpc/kernel/pci-common.c                |  7 ++-
 arch/powerpc/kernel/process.c                   | 20 -------
 arch/powerpc/kernel/prom_init.c                 |  2 +-
 arch/powerpc/kernel/ptrace.c                    | 19 +++++++
 arch/powerpc/kernel/setup_32.c                  |  9 ++--
 arch/powerpc/kernel/setup_64.c                  |  1 +
 arch/powerpc/kernel/vdso.c                      |  1 +
 arch/powerpc/kernel/vdso32/Makefile             |  6 +--
 arch/powerpc/kernel/vdso64/Makefile             |  6 +--
 arch/powerpc/lib/checksum_32.S                  |  7 +--
 arch/powerpc/lib/feature-fixups.c               |  3 ++
 arch/powerpc/platforms/cell/spufs/inode.c       |  4 +-
 arch/powerpc/platforms/pasemi/iommu.c           |  5 ++
 arch/powerpc/platforms/powernv/opal-irqchip.c   |  3 +-
 arch/powerpc/platforms/powernv/opal.c           |  1 +
 arch/powerpc/platforms/powernv/pci-ioda.c       | 32 ++++++++----
 arch/powerpc/platforms/pseries/hotplug-memory.c | 26 +++++-----
 arch/powerpc/sysdev/xics/Kconfig                |  1 +
 arch/powerpc/sysdev/xics/ics-opal.c             |  4 +-
 arch/powerpc/sysdev/xics/ics-rtas.c             |  4 +-
 arch/powerpc/sysdev/xics/xics-common.c          | 59 ++++++++++++++++++---
 drivers/misc/cxl/context.c                      |  3 +-
 drivers/misc/cxl/cxl.h                          |  2 +-
 drivers/misc/cxl/native.c                       |  2 +-
 drivers/misc/cxl/pci.c                          | 12 +++--
 drivers/misc/cxl/vphb.c                         |  2 +-
 include/uapi/misc/cxl.h                         |  4 +-
 tools/testing/selftests/powerpc/Makefile        |  2 +-
 38 files changed, 242 insertions(+), 147 deletions(-)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrZVRAAoJEFHr6jzI4aWAjg8QALAcJxF7wyBt9s6IY3ztvglX
nTMldhVJt0SPWQUOILeaASNl7QlSK8RK/z5+PZ8OV+Zx1dIAGS9QWYeiRJNITCVG
yaVP2TXWIabqwgocbJ8KLNF0xKN5ltKqYp0wRPaXklZSK2nyvCkN4UddLY8CzCtT
2DFzmWJil8DTiZECLe9vj5M/4JWvCDhR88MskFC37xGeav1emYQ1jqY5mCnubVJg
1MvHhsZgdUHRimCB6y4oDYYRg8ZnuJDWcW9ed7YqVqr35AVn74FL+BkvsjD4vDpK
rFbD1/C+cgjBeN5wGi3SaZCJ2D36X0/t3agR/Wp10EadNLaVcmSfG97zbGbj0BrK
PvLlw7H9nbsa2yhjSEBJNt539deIJAG+UeoYHqlYMyqGXLnwZFFiUQRJTbVVETPl
/P+AUCgC1xR1puRkQk2gWZ+T1PhvVZEdy/pOfUi/ph2brPqJ2W5WZvrbbOOhE1oI
1qMYS4LJlobrmsMHcDxyW8gl4JsyyJaWzFw/7lSPvFiIWGXhL2j3pcBQspW71mye
QeWf7Hf+AxbEpB/uDIoLJQOA4jVj3PDLvqVeGJXLWdFrStNps5QYSdjwtuqItV6u
V4cj6QZ6+sNxGL6nZC4hwpg/Q842AwPNtdGNLhaYDtQxfM3ccexmuxQ6boahpAkM
QfIKkddg8+l7BFRZq9OQ
=1BKW
-----END PGP SIGNATURE-----
--=-=-=--
