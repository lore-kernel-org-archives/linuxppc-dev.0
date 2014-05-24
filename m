Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-x22b.google.com (mail-lb0-x22b.google.com
 [IPv6:2a00:1450:4010:c04::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3EAB21A0591
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 19:33:42 +1000 (EST)
Received: by mail-lb0-f171.google.com with SMTP id 10so3282008lbg.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 02:33:37 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/3] dmaengine: mpc512x: add device tree binding document and
 DMA channel lookup
Date: Sat, 24 May 2014 13:33:26 +0400
Message-Id: <1400924009-23992-1-git-send-email-a13xp0p0v88@gmail.com>
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

Alexander Popov (3):
  dmaengine: mpc512x: add device tree binding document
  dmaengine: of: add common xlate function for matching by channel id
  dmaengine: mpc512x: register for device tree channel lookup

 .../devicetree/bindings/dma/mpc512x-dma.txt        | 40 ++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc5121.dtsi                 |  1 +
 drivers/dma/mpc512x_dma.c                          | 13 ++++++-
 drivers/dma/of-dma.c                               | 35 +++++++++++++++++++
 include/linux/of_dma.h                             |  4 +++
 5 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt

-- 
1.8.4.2
