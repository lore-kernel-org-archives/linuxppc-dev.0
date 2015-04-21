Return-Path: <stripath@apm.com>
Received: from denmail01.amcc.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 92B731A0214
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 01:43:45 +1000 (AEST)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, ulf.hansson@linaro.org, anton@enomsg.org, arnd@arndb.de
Subject: [PATCH v2 RESEND 0/2] Add SDHCI support for APM X-Gene SoC using
 ARASAN SDHCI controller.
Date: Tue, 21 Apr 2015 21:12:37 +0530
Message-Id: <1429630959-32649-1-git-send-email-stripathi@apm.com>
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
 * Drop the IOMMU support and switching to PIO mode for arasan 
   controller integrated inside APM X-Gene SoC.

Signed-off-by: Suman Tripathi <stripathi@apm.com>

Suman Tripathi (2):
  arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
  mmc: host: Add some quirks to be read from fdt in sdhci-pltm.c

 arch/arm64/boot/dts/apm-storm.dtsi | 44 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c     | 15 +++++++++++++
 2 files changed, 59 insertions(+)

-- 
1.8.2.1
