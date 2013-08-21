Return-Path: <libo.chen@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 696AF2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 17:18:06 +1000 (EST)
From: Libo Chen <libo.chen@huawei.com>
To: <davem@davemloft.net>
Subject: [PATCH 0/8] net: remove unnecessary dev_set_drvdata()
Date: Wed, 21 Aug 2013 15:05:37 +0800
Message-ID: <1377068737-48616-1-git-send-email-libo.chen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mugunthanvnm@ti.com, sergei.shtylyov@cogentembedded.com,
 netdev@vger.kernel.org, jg1.han@samsung.com, libo.chen@huawei.com,
 lizefan@huawei.com, gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unnecessary dev_set_drvdata() is removed, because the driver core
clears the driver data to NULL after device_release or on probe failure.

Libo Chen (8):
  net: fsl_pq_mdio: remove unnecessary dev_set_drvdata()
  net: ucc_geth: remove unnecessary dev_set_drvdata()
  net: fec_mpc52xx_phy: remove unnecessary dev_set_drvdata()
  net: sunbmac: remove unnecessary dev_set_drvdata()
  net: sunhme: remove unnecessary dev_set_drvdata()
  net: xilinx_emaclite: remove unnecessary dev_set_drvdata()
  net: davinci_mdio: remove unnecessary dev_set_drvdata()
  net: emac: remove unnecessary dev_set_drvdata()

 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c |    1 -
 drivers/net/ethernet/freescale/fsl_pq_mdio.c     |    2 --
 drivers/net/ethernet/freescale/ucc_geth.c        |    1 -
 drivers/net/ethernet/ibm/emac/core.c             |    2 --
 drivers/net/ethernet/sun/sunbmac.c               |    2 --
 drivers/net/ethernet/sun/sunhme.c                |    2 --
 drivers/net/ethernet/ti/davinci_mdio.c           |    2 --
 drivers/net/ethernet/xilinx/xilinx_emaclite.c    |    1 -
 8 files changed, 0 insertions(+), 13 deletions(-)
