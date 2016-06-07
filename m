Return-Path: <peter.griffin@linaro.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPJjd6QFBzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 03:39:49 +1000 (AEST)
Received: by mail-wm0-f50.google.com with SMTP id n184so147704874wmn.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 10:39:48 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@stlinux.com, vinod.koul@intel.com, linus.walleij@linaro.org,
 dan.j.williams@intel.com, leoli@freescale.com, zw@zh-kernel.org,
 baohua@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org,
 ldewangan@nvidia.com, jonathanh@nvidia.com, swarren@wwwdotorg.org,
 thierry.reding@gmail.com, gnurou@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/8]  Various dmaengine cleanups
Date: Tue,  7 Jun 2016 18:38:33 +0100
Message-Id: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vinod,

This series is a bunch of cleanup updates to various
dmaengine drivers, based on some of the review feeback to my fdma series.

regards,

Peter.

Peter Griffin (8):
  dmaengine: fsl-edma: Fix clock handling error paths
  dmaengine: fsl-edma: print error code in error messages.
  dmaengine: coh901318: Only calculate residue if txstate exists.
  dmaengine: s3c24xx: Simplify code in s3c24xx_dma_tx_status()
  dmaengine: ste_dma40: Only calculate residue if txstate exists.
  dmaengine: sun6i-dma: Only calculate residue if state exists.
  dmaengine: tegra20-apb-dma: Only calculate residue if txstate exists.
  dmaengine: Remove site specific OOM error messages on kzalloc

 drivers/dma/amba-pl08x.c        | 10 +---------
 drivers/dma/bestcomm/bestcomm.c |  2 --
 drivers/dma/coh901318.c         |  2 +-
 drivers/dma/edma.c              | 16 ++++------------
 drivers/dma/fsl-edma.c          | 25 +++++++++++++++++++------
 drivers/dma/fsldma.c            |  2 --
 drivers/dma/k3dma.c             | 10 ++++------
 drivers/dma/mmp_tdma.c          |  5 ++---
 drivers/dma/moxart-dma.c        |  4 +---
 drivers/dma/nbpfaxi.c           |  5 ++---
 drivers/dma/pl330.c             |  5 +----
 drivers/dma/ppc4xx/adma.c       |  2 --
 drivers/dma/s3c24xx-dma.c       | 11 ++---------
 drivers/dma/sh/shdmac.c         |  9 ++-------
 drivers/dma/sh/sudmac.c         |  9 ++-------
 drivers/dma/sirf-dma.c          |  5 ++---
 drivers/dma/ste_dma40.c         |  6 ++----
 drivers/dma/sun6i-dma.c         |  2 +-
 drivers/dma/tegra20-apb-dma.c   | 13 ++++---------
 drivers/dma/timb_dma.c          |  8 ++------
 20 files changed, 52 insertions(+), 99 deletions(-)

-- 
1.9.1
