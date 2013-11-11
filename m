Return-Path: <hongbo.zhang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6701E2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 21:26:33 +1100 (EST)
From: <hongbo.zhang@freescale.com>
To: <dan.j.williams@intel.com>, <vinod.koul@intel.com>,
 <dmaengine@vger.kernel.org>
Subject: [PATCH resend 0/3] DMA: Freescale: Add support for 8-channel DMA
 engine
Date: Mon, 11 Nov 2013 18:26:04 +0800
Message-ID: <1384165567-4883-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Hongbo Zhang <hongbo.zhang@freescale.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hongbo Zhang <hongbo.zhang@freescale.com>

Hi Dan Williams and Vinod Koul,

This time only resend all patches to the new dmaengine patchwork at
dmaengine(at)vger.kernel.org as Dan Williams suggested.

Patch 1/3 and 2/3 have been Acked-by: Mark Rutland <mark.rutland@arm.com>
after several iterations of review.

Hongbo Zhang (3):
  DMA: Freescale: revise device tree binding document
  DMA: Freescale: Add new 8-channel DMA engine device tree nodes
  DMA: Freescale: update driver to support 8-channel DMA engine

 .../devicetree/bindings/powerpc/fsl/dma.txt        |  138 ++++++++++++++------
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |    4 +-
 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi          |   82 ++++++++++++
 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi          |   82 ++++++++++++
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |    4 +-
 drivers/dma/Kconfig                                |    9 +-
 drivers/dma/fsldma.c                               |    9 +-
 drivers/dma/fsldma.h                               |    2 +-
 8 files changed, 281 insertions(+), 49 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi

-- 
1.7.9.5
