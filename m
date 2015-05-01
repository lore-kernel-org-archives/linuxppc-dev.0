Return-Path: <stripath@apm.com>
Received: from denmail01.amcc.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id F40D21A0D67
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 14:55:29 +1000 (AEST)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com
Subject: [PATCH v3 0/3] Add SDHCI support for APM X-Gene SoC using ARASAN
 SDHCI controller.
Date: Fri,  1 May 2015 10:24:09 +0530
Message-Id: <1430456052-8888-1-git-send-email-stripathi@apm.com>
Cc: devicetree@vger.kernel.org, mlangsdo@redhat.com,
 Suman Tripathi <stripathi@apm.com>, jcm@redhat.com, linux-mmc@vger.kernel.org,
 patches@apm.com, ddutile@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.

v1 change:
 * Use the CONFIG_ARM64_DMA_HAS_IOMMU for dma-mapping.

v2 change:
 * Drop the IOMMU support and switching to PIO mode for arasan.
   controller integrated inside APM X-Gene SoC.

v3 change:
 * Change the sdhci-of-arasan.c to support arasan4.9a.
 * Add quirks for arasan4.9a.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---

Suman Tripathi (3):
  arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
  mmc: host: arasan: Add the support for sdhci-arasan4.9a in
    sdhci-of-arasan.c
  Documentation: mmc: Update Arasan SDHC documentation to support 4.9a
    version of     Arasan SDHC controller.

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  5 ++-
 arch/arm64/boot/dts/apm-mustang.dts                |  4 ++
 arch/arm64/boot/dts/apm-storm.dtsi                 | 44 ++++++++++++++++++++++
 drivers/mmc/host/sdhci-of-arasan.c                 |  7 ++++
 4 files changed, 58 insertions(+), 2 deletions(-)

--
1.8.2.1
