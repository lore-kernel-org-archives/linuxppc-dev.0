Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0059.outbound.protection.outlook.com [104.47.33.59])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbFll1cc5zDsfg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 23:01:23 +1000 (AEST)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH 0/5] Freescale DPAA 1.x QBMan Drivers 
Date: Fri, 16 Sep 2016 16:00:27 +0300
Message-ID: <1474030832-20611-1-git-send-email-claudiu.manoil@nxp.com>
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

Add basic support for the Data Path Acceleration Architecture v1.x
(DPAA 1.x) hardware infrastructure and accelerators found on multicore
Freescale SoCs, commonly known as the QorIQ series.

CC: Roy Pledge <roy.pledge@nxp.com>

Claudiu Manoil (5):
  soc/fsl: Introduce DPAA 1.x BMan device driver
  soc/fsl: Introduce DPAA 1.x QMan device driver
  soc/bman: Add self-test for BMan driver
  soc/qman: Add self-test for QMan driver
  arch/powerpc: Add CONFIG_FSL_DPAA to corenetXX_smp_defconfig

 arch/powerpc/Makefile                   |    4 +-
 arch/powerpc/configs/dpaa.config        |    1 +
 drivers/soc/Kconfig                     |    1 +
 drivers/soc/fsl/Makefile                |    1 +
 drivers/soc/fsl/qbman/Kconfig           |   67 +
 drivers/soc/fsl/qbman/Makefile          |   12 +
 drivers/soc/fsl/qbman/bman.c            |  797 +++++++++
 drivers/soc/fsl/qbman/bman_ccsr.c       |  263 +++
 drivers/soc/fsl/qbman/bman_portal.c     |  215 +++
 drivers/soc/fsl/qbman/bman_priv.h       |   80 +
 drivers/soc/fsl/qbman/bman_test.c       |   53 +
 drivers/soc/fsl/qbman/bman_test.h       |   35 +
 drivers/soc/fsl/qbman/bman_test_api.c   |  151 ++
 drivers/soc/fsl/qbman/dpaa_sys.h        |  103 ++
 drivers/soc/fsl/qbman/qman.c            | 2881 +++++++++++++++++++++++++++++++
 drivers/soc/fsl/qbman/qman_ccsr.c       |  817 +++++++++
 drivers/soc/fsl/qbman/qman_portal.c     |  354 ++++
 drivers/soc/fsl/qbman/qman_priv.h       |  370 ++++
 drivers/soc/fsl/qbman/qman_test.c       |   62 +
 drivers/soc/fsl/qbman/qman_test.h       |   36 +
 drivers/soc/fsl/qbman/qman_test_api.c   |  252 +++
 drivers/soc/fsl/qbman/qman_test_stash.c |  617 +++++++
 include/soc/fsl/bman.h                  |  129 ++
 include/soc/fsl/qman.h                  | 1076 ++++++++++++
 24 files changed, 8375 insertions(+), 2 deletions(-)
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

-- 
1.7.11.7
