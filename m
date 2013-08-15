Return-Path: <libo.chen@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BB06B2C024B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 23:01:45 +1000 (EST)
Message-ID: <520CD11D.8010202@huawei.com>
Date: Thu, 15 Aug 2013 21:01:17 +0800
From: Libo Chen <clbchenlibo.chen@huawei.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: [PATCH v3 0/7] net: use platform_{get,set}_drvdata()
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 Greg KH <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 jg1.han@samsung.com, Li Zefan <lizefan@huawei.com>, vbordug@ru.mvista.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
so we can directly pass a struct platform_device.

changelog v3:
	remove modify about dev_set_drvdata()
changelog v2:
	this version add modify record about dev_set_drvdata().

Libo Chen (7):
  net: fsl_pq_mdio: use platform_{get,set}_drvdata()
  net: ucc_geth: use platform_{get,set}_drvdata()
  net: fec_mpc52xx_phy: use platform_{get,set}_drvdata()
  net: sunbmac: use platform_{get,set}_drvdata()
  net: sunhme: use platform_{get,set}_drvdata()
  net: xilinx_emaclite: use platform_{get,set}_drvdata()
  net: davinci_mdio: use platform_{get,set}_drvdata()

 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c |    3 +--
 drivers/net/ethernet/freescale/fsl_pq_mdio.c     |    2 +-
 drivers/net/ethernet/freescale/ucc_geth.c        |    3 +--
 drivers/net/ethernet/sun/sunbmac.c               |    2 +-
 drivers/net/ethernet/sun/sunhme.c                |    6 +++---
 drivers/net/ethernet/ti/davinci_mdio.c           |    3 +--
 drivers/net/ethernet/xilinx/xilinx_emaclite.c    |    3 +--
 7 files changed, 9 insertions(+), 13 deletions(-)
