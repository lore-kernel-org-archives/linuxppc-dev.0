Return-Path: <madalin.bucur@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GL1h4fztzF3PC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 01:17:12 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: leoyang.li@nxp.com
Cc: roy.pledge@nxp.com, claudiu.manoil@nxp.com, catalin.marinas@arm.com,
 oss@buserror.net, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 0/4] soc/fsl/qbman: DPAA QBMan fixes and additions
Date: Thu, 20 Sep 2018 18:06:47 +0300
Message-Id: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set brings a number of fixes and the option to control
the QMan portal interrupt coalescing.

Madalin Bucur (1):
  soc/fsl_qbman: export coalesce change API

Roy Pledge (3):
  soc/fsl/qbman: Check if CPU is offline when initializing portals
  soc/fsl/qbman: Add 64 bit DMA addressing requirement to QBMan
  soc/fsl/qbman: Use last response to determine valid bit

 drivers/soc/fsl/qbman/Kconfig |  2 +-
 drivers/soc/fsl/qbman/bman.c  | 17 ++++++++---
 drivers/soc/fsl/qbman/qman.c  | 65 ++++++++++++++++++++++++++++++++++++++-----
 include/soc/fsl/qman.h        | 27 ++++++++++++++++++
 4 files changed, 99 insertions(+), 12 deletions(-)

-- 
2.1.0
