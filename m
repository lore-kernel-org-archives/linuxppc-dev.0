Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 60BB61A1903
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Oct 2014 02:49:27 +1000 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] fsl: fsl-spi: Fix CMP1 pram allocation and allow
 dynamic allocation
Message-Id: <20141003164916.BA7611AAFC7@localhost.localdomain>
Date: Fri,  3 Oct 2014 18:49:16 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset:
1) Fix parameter ram offset setup for CPM1
2) Allow dynamic allocation of CPM1 parameter RAM

Tested on MPC885.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
Changes from v1 to v2: using OF compatible instead of compile time option

 drivers/spi/spi-fsl-cpm.c   | 12 +++++++-----
 drivers/spi/spi-fsl-lib.c   |  2 ++
 include/linux/fsl_devices.h |  1 +
 3 files changed, 10 insertions(+), 5 deletions(-)
