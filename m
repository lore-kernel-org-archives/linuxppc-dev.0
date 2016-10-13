Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svmYn1n2JzDsyY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 21:05:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds  <torvalds@linux-foundation.org>
Cc: andrew.smirnov@gmail.com, bsingharora@gmail.com, christophe.leroy@c-s.fr,
 claudiu.manoil@nxp.com, haokexin@gmail.com, julia.lawall@lip6.fr,
 ldufour@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, olof@lixom.net,
 oss@buserror.net, paulus@ozlabs.org, qiang.zhao@nxp.com,
 vaishali.thakkar@oracle.com, wsa@the-dreams.de
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.9-2 tag
Date: Thu, 13 Oct 2016 21:04:59 +1100
Message-ID: <87oa2or2d0.fsf@concordia.ellerman.id.au>
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

Please pull some more powerpc updates for 4.9:

The following changes since commit b7b7013cac55d794940bd9cb7b7c55c9dececac4:

  powerpc/bpf: Add support for bpf constant blinding (2016-10-04 20:33:20 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.9-2

for you to fetch changes up to 08bf75ba852ef8304a84b6a030466b4b4850382e:

  powerpc/mm/hash64: Fix might_have_hea() check (2016-10-12 08:32:28 +1100)

----------------------------------------------------------------
powerpc updates for 4.9 #2

Freescale updates from Scott:

"Highlights include qbman support (a prerequisite for datapath drivers
such as ethernet), a PCI DMA fix+improvement, reset handler changes, more
8xx optimizations, and some cleanups and fixes."

Fixes:
 - selftests/powerpc: Add missing binaries to .gitignores (Michael Ellerman)
 - selftests/powerpc: Fix build break caused by EXPORT_SYMBOL changes (Michael Ellerman)
 - powerpc/pseries: Fix stack corruption in htpe code (Laurent Dufour)
 - powerpc/64s: Fix power4_fixup_nap placement (Nicholas Piggin)
 - powerpc/64: Fix incorrect return value from __copy_tofrom_user (Paul Mackerras)
 - powerpc/mm/hash64: Fix might_have_hea() check (Michael Ellerman)

Other:
 - MAINTAINERS: Remove myself from PA Semi entries (Olof Johansson)
 - MAINTAINERS: Drop separate pseries entry (Michael Ellerman)
 - MAINTAINERS: Update powerpc website & add selftests (Michael Ellerman)

----------------------------------------------------------------
Andrey Smirnov (6):
      powerpc/mpc85xx_mds: Select PHYLIB only if NETDEVICES is enabled
      powerpc/e8248e: Select PHYLIB only if NETDEVICES is enabled
      powerpc/sgy_cts1000: Fix gpio_halt_cb()'s signature
      powerpc: Factor out common code in setup-common.c
      powerpc: Call chained reset handlers during reset
      powerpc: Convert fsl_rstcr_restart to a reset handler

Christophe Leroy (9):
      powerpc32: Use instruction symbolic names in check_io_access()
      soc/fsl/qe: fix Oops on CPM1 (and likely CPM2)
      powerpc/8xx: use SPRN_EIE and SPRN_EID to enable/disable interrupts
      powerpc/8xx: add system_reset_exception
      powerpc/8xx: add dedicated machine check handler
      soc/fsl/qe: fix gpio save_regs functions
      powerpc/8xx: use r3 to scratch CR in ITLBmiss
      powerpc/8xx: Move additional DTLBMiss handlers out of exception area
      powerpc/8xx: make user addr DTLB miss the short path

Claudiu Manoil (5):
      soc/fsl: Introduce DPAA 1.x BMan device driver
      soc/fsl: Introduce DPAA 1.x QMan device driver
      soc/bman: Add self-test for BMan driver
      soc/qman: Add self-test for QMan driver
      arch/powerpc: Add CONFIG_FSL_DPAA to corenetXX_smp_defconfig

Julia Lawall (2):
      fsl/qe: use of_property_read_bool
      powerpc/mpic: use of_property_read_bool

Kevin Hao (1):
      powerpc/83xx: factor out the common codes of setup arch functions

Laurent Dufour (1):
      powerpc/pseries: Fix stack corruption in htpe code

Michael Ellerman (6):
      selftests/powerpc: Add missing binaries to .gitignores
      MAINTAINERS: Drop separate pseries entry
      MAINTAINERS: Update powerpc website & add selftests
      selftests/powerpc: Fix build break caused by EXPORT_SYMBOL changes
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into next
      powerpc/mm/hash64: Fix might_have_hea() check

Nicholas Piggin (1):
      powerpc/64s: Fix power4_fixup_nap placement

Olof Johansson (1):
      MAINTAINERS: Remove myself from PA Semi entries

Paul Mackerras (1):
      powerpc/64: Fix incorrect return value from __copy_tofrom_user

Scott Wood (1):
      powerpc/fsl_pci: Size upper inbound window based on RAM size

Vaishali Thakkar (1):
      soc/fsl/qe: Use resource_size

Zhao Qiang (1):
      soc/fsl/qe: Use of_adress_to_resource() in get_qe_base()

 MAINTAINERS                                        |   18 +-
 arch/powerpc/Makefile                              |    4 +-
 arch/powerpc/configs/dpaa.config                   |    1 +
 arch/powerpc/include/asm/cputable.h                |    1 +
 arch/powerpc/include/asm/hw_irq.h                  |    6 +
 arch/powerpc/include/asm/ppc-opcode.h              |    1 +
 arch/powerpc/include/asm/reg.h                     |    2 +
 arch/powerpc/include/asm/reg_8xx.h                 |    4 +
 arch/powerpc/kernel/cputable.c                     |    1 +
 arch/powerpc/kernel/exceptions-64s.S               |    2 +-
 arch/powerpc/kernel/head_8xx.S                     |  136 +-
 arch/powerpc/kernel/setup-common.c                 |   27 +-
 arch/powerpc/kernel/traps.c                        |   45 +-
 arch/powerpc/lib/copyuser_64.S                     |    2 +-
 arch/powerpc/mm/hash_utils_64.c                    |    2 +-
 arch/powerpc/platforms/82xx/Kconfig                |    4 +-
 arch/powerpc/platforms/82xx/ep8248e.c              |    4 +-
 arch/powerpc/platforms/83xx/asp834x.c              |    4 +-
 arch/powerpc/platforms/83xx/km83xx.c               |    5 +-
 arch/powerpc/platforms/83xx/misc.c                 |    8 +
 arch/powerpc/platforms/83xx/mpc830x_rdb.c          |    5 +-
 arch/powerpc/platforms/83xx/mpc831x_rdb.c          |    5 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |    5 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |    5 +-
 arch/powerpc/platforms/83xx/mpc834x_itx.c          |    5 +-
 arch/powerpc/platforms/83xx/mpc834x_mds.c          |    5 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |    5 +-
 arch/powerpc/platforms/83xx/mpc836x_rdk.c          |    5 +-
 arch/powerpc/platforms/83xx/mpc837x_mds.c          |    5 +-
 arch/powerpc/platforms/83xx/mpc837x_rdb.c          |    5 +-
 arch/powerpc/platforms/83xx/mpc83xx.h              |    1 +
 arch/powerpc/platforms/83xx/sbc834x.c              |    5 +-
 arch/powerpc/platforms/85xx/Kconfig                |    2 +-
 arch/powerpc/platforms/85xx/bsc913x_qds.c          |    1 -
 arch/powerpc/platforms/85xx/bsc913x_rdb.c          |    1 -
 arch/powerpc/platforms/85xx/c293pcie.c             |    1 -
 arch/powerpc/platforms/85xx/corenet_generic.c      |    1 -
 arch/powerpc/platforms/85xx/ge_imp3a.c             |    1 -
 arch/powerpc/platforms/85xx/mpc8536_ds.c           |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_cds.c          |   25 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c           |    3 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   12 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   10 -
 arch/powerpc/platforms/85xx/mvme2500.c             |    1 -
 arch/powerpc/platforms/85xx/p1010rdb.c             |    1 -
 arch/powerpc/platforms/85xx/p1022_ds.c             |    1 -
 arch/powerpc/platforms/85xx/p1022_rdk.c            |    1 -
 arch/powerpc/platforms/85xx/p1023_rdb.c            |    1 -
 arch/powerpc/platforms/85xx/ppa8548.c              |    1 -
 arch/powerpc/platforms/85xx/qemu_e500.c            |    1 -
 arch/powerpc/platforms/85xx/sbc8548.c              |    1 -
 arch/powerpc/platforms/85xx/sgy_cts1000.c          |    8 +-
 arch/powerpc/platforms/85xx/socrates.c             |    1 -
 arch/powerpc/platforms/85xx/stx_gp3.c              |    1 -
 arch/powerpc/platforms/85xx/tqm85xx.c              |    1 -
 arch/powerpc/platforms/85xx/twr_p102x.c            |    1 -
 arch/powerpc/platforms/85xx/xes_mpc85xx.c          |    3 -
 arch/powerpc/platforms/86xx/gef_ppc9a.c            |    1 -
 arch/powerpc/platforms/86xx/gef_sbc310.c           |    1 -
 arch/powerpc/platforms/86xx/gef_sbc610.c           |    1 -
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |    1 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |    1 -
 arch/powerpc/platforms/86xx/mvme7100.c             |    1 -
 arch/powerpc/platforms/86xx/sbc8641d.c             |    1 -
 arch/powerpc/platforms/pseries/lpar.c              |    4 +-
 arch/powerpc/sysdev/cpm1.c                         |    2 -
 arch/powerpc/sysdev/cpm2.c                         |    4 -
 arch/powerpc/sysdev/cpm_common.c                   |   15 +
 arch/powerpc/sysdev/fsl_pci.c                      |   12 +-
 arch/powerpc/sysdev/fsl_soc.c                      |   33 +-
 arch/powerpc/sysdev/fsl_soc.h                      |    2 -
 arch/powerpc/sysdev/mpic.c                         |    2 +-
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/fsl/Makefile                           |    1 +
 drivers/soc/fsl/qbman/Kconfig                      |   67 +
 drivers/soc/fsl/qbman/Makefile                     |   12 +
 drivers/soc/fsl/qbman/bman.c                       |  797 ++++++
 drivers/soc/fsl/qbman/bman_ccsr.c                  |  263 ++
 drivers/soc/fsl/qbman/bman_portal.c                |  219 ++
 drivers/soc/fsl/qbman/bman_priv.h                  |   80 +
 drivers/soc/fsl/qbman/bman_test.c                  |   53 +
 drivers/soc/fsl/qbman/bman_test.h                  |   35 +
 drivers/soc/fsl/qbman/bman_test_api.c              |  151 +
 drivers/soc/fsl/qbman/dpaa_sys.h                   |  103 +
 drivers/soc/fsl/qbman/qman.c                       | 2881 ++++++++++++++++++++
 drivers/soc/fsl/qbman/qman_ccsr.c                  |  808 ++++++
 drivers/soc/fsl/qbman/qman_portal.c                |  355 +++
 drivers/soc/fsl/qbman/qman_priv.h                  |  371 +++
 drivers/soc/fsl/qbman/qman_test.c                  |   62 +
 drivers/soc/fsl/qbman/qman_test.h                  |   36 +
 drivers/soc/fsl/qbman/qman_test_api.c              |  252 ++
 drivers/soc/fsl/qbman/qman_test_stash.c            |  617 +++++
 drivers/soc/fsl/qe/gpio.c                          |    3 +-
 drivers/soc/fsl/qe/qe.c                            |   10 +-
 drivers/soc/fsl/qe/qe_common.c                     |    8 +
 drivers/soc/fsl/qe/qe_tdm.c                        |    4 +-
 include/soc/fsl/bman.h                             |  129 +
 include/soc/fsl/qman.h                             | 1074 ++++++++
 .../selftests/powerpc/copyloops/asm/export.h       |    1 +
 tools/testing/selftests/powerpc/math/.gitignore    |    1 +
 tools/testing/selftests/powerpc/signal/.gitignore  |    2 +
 .../selftests/powerpc/stringloops/asm/export.h     |    1 +
 tools/testing/selftests/powerpc/tm/.gitignore      |    4 +
 104 files changed, 8631 insertions(+), 266 deletions(-)
 create mode 100644 arch/powerpc/configs/dpaa.config
 create mode 100644 drivers/soc/fsl/qbman/Kconfig
 create mode 100644 drivers/soc/fsl/qbman/Makefile
 create mode 100644 drivers/soc/fsl/qbman/bman.c
 create mode 100644 drivers/soc/fsl/qbman/bman_ccsr.c
 create mode 100644 drivers/soc/fsl/qbman/bman_portal.c
 create mode 100644 drivers/soc/fsl/qbman/bman_priv.h
 create mode 100644 drivers/soc/fsl/qbman/bman_test.c
 create mode 100644 drivers/soc/fsl/qbman/bman_test.h
 create mode 100644 drivers/soc/fsl/qbman/bman_test_api.c
 create mode 100644 drivers/soc/fsl/qbman/dpaa_sys.h
 create mode 100644 drivers/soc/fsl/qbman/qman.c
 create mode 100644 drivers/soc/fsl/qbman/qman_ccsr.c
 create mode 100644 drivers/soc/fsl/qbman/qman_portal.c
 create mode 100644 drivers/soc/fsl/qbman/qman_priv.h
 create mode 100644 drivers/soc/fsl/qbman/qman_test.c
 create mode 100644 drivers/soc/fsl/qbman/qman_test.h
 create mode 100644 drivers/soc/fsl/qbman/qman_test_api.c
 create mode 100644 drivers/soc/fsl/qbman/qman_test_stash.c
 create mode 100644 include/soc/fsl/bman.h
 create mode 100644 include/soc/fsl/qman.h
 create mode 100644 tools/testing/selftests/powerpc/copyloops/asm/export.h
 create mode 100644 tools/testing/selftests/powerpc/signal/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/stringloops/asm/export.h

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX/1xLAAoJEFHr6jzI4aWAO3YQAJcgE4rR84KAeadITNX7gHRq
fz5JkOG9YZk9321xb3+lHWBkI8RLG1+9nOgW4KL8QhO7Yv56BXUg5j2hDHRO8OHm
URhoc+qxf9QsMurL5yO7NViO+pD9BkglH6hv5JHE05OOrTLyaz834IUIihmgzasa
4mvt3bkG7OuWGoslySavEJxA4qxif/84PGPdwja86tY+E2KEnLd6hxB+CwrbYlYx
CBEwOYbHCcnn74cOtXcvI4QTgET89NAEQEula6k8GxYA6+ZBwLqwrFsisnf6ihi8
/wGwHlm3F/7BgBgSvjvtpi5kEHiM2yTYQbUBCv/bMyQPSrdrVr2uApNkjdTIb6iP
i3MJMHnaRItKYFODKLXv5dQNUDolWq69NKZmgYWwrB4KYLm63gUcgtzBkQHydzXa
P9i4bOb6XTZlR4NIEqxB9hL1C3elM3F6xTAfUVkcpRk09Ksy29WTda0kN/NVepy3
kFvmT8cUHBGntIeLebZkD4YiWtDxX9R14SrO0EbQAo7klQk6miHkvpf5KyoB/XPK
3Q41Jm7DSf3oIpacvQRGMuF3gHwFWSWNX1KWUM5SaaChsdAcocK921BvIZGUaEe/
kJzHcYewpbhu4T5ZSrXssW6iEQkREz5BjpRwPCZLH+H74CiooV5iwB7qv+ItIpDr
PPaVKYhvmffenloPWR0v
=9zmG
-----END PGP SIGNATURE-----
--=-=-=--
