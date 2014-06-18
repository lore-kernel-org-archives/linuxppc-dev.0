Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-x22f.google.com (mail-la0-x22f.google.com
 [IPv6:2a00:1450:4010:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DA581A02C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 20:48:35 +1000 (EST)
Received: by mail-la0-f47.google.com with SMTP id s18so384347lam.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 03:48:29 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] dmaengine: mpc512x: add device tree binding document
 and DMA channel lookup
Date: Wed, 18 Jun 2014 14:48:09 +0400
Message-Id: <1403088492-15241-1-git-send-email-a13xp0p0v88@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series introduces a device tree binding document for
the MPC512x DMA controller and adds device tree based DMA channel lookup
for it.

This version has improved device tree binding document.

Alexander Popov (3):
  dmaengine: mpc512x: add device tree binding document
  dmaengine: of: add common xlate function for matching by channel id
  dmaengine: mpc512x: register for device tree channel lookup

 .../devicetree/bindings/dma/mpc512x-dma.txt        | 31 +++++++++++++++++++
 arch/powerpc/boot/dts/mpc5121.dtsi                 |  1 +
 drivers/dma/mpc512x_dma.c                          | 13 +++++++-
 drivers/dma/of-dma.c                               | 35 ++++++++++++++++++++++
 include/linux/of_dma.h                             |  4 +++
 5 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt

-- 
1.8.4.2
