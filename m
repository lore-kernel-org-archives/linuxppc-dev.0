Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0F8812C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Apr 2013 16:03:29 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: netdev@vger.kernel.org
Subject: [PATCH 0/3] freescale: Update logging style
Date: Sat, 13 Apr 2013 22:03:16 -0700
Message-Id: <cover.1365915548.git.joe@perches.com>
Cc: linuxppc-dev@lists.ozlabs.org, Fabio Estevam <festevam@gmail.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert various printk logging styles to current styles.

Uncompiled, untested.

Joe Perches (3):
  fec: Convert printks to netdev_<level>
  gianfar: Use netdev_<level> when possible
  ucc_geth: Convert ugeth_<level> to pr_<level>

 drivers/net/ethernet/freescale/fec_main.c         |  26 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c      |  16 +-
 drivers/net/ethernet/freescale/fec_ptp.c          |   2 +
 drivers/net/ethernet/freescale/gianfar_ethtool.c  |  24 +-
 drivers/net/ethernet/freescale/gianfar_ptp.c      |   3 +
 drivers/net/ethernet/freescale/gianfar_sysfs.c    |   2 +-
 drivers/net/ethernet/freescale/ucc_geth.c         | 881 ++++++++++------------
 drivers/net/ethernet/freescale/ucc_geth_ethtool.c |  24 +-
 8 files changed, 441 insertions(+), 537 deletions(-)

-- 
1.8.1.2.459.gbcd45b4.dirty
