Return-Path: <stripath@apm.com>
Received: from denmail01.apm.com (unknown [192.195.68.30])
 by lists.ozlabs.org (Postfix) with ESMTP id A55221A0198
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 04:16:41 +1100 (AEDT)
From: Suman Tripathi <stripathi@apm.com>
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de
Subject: [PATCH 0/2] Add SDHCI support for APM X-Gene SoC using ARASAN SDHCI
 controller.
Date: Mon, 15 Dec 2014 22:31:05 +0530
Message-Id: <1418662867-9210-1-git-send-email-stripathi@apm.com>
Cc: devicetree@vger.kernel.org, Suman Tripathi <stripathi@apm.com>,
 jcm@redhat.com, linux-mmc@vger.kernel.org, patches@apm.com, ddutile@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Due to the fact that the existing of-arasan driver works with 32-bit platforms.
This patch tweaks existing of-arasan driver to work with 64-bit X-Gene
platform using IOMMU translation.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---

Suman Tripathi (2):
  mmc: host: arasan: Add addition of-arasan quirks and add IOMMU
    support.
  arm64: dts: Add  APM X-Gene SDHCI DTS node.

 arch/arm64/boot/dts/apm-storm.dtsi | 43 ++++++++++++++++++++++++++++++
 drivers/mmc/host/Kconfig           |  1 +
 drivers/mmc/host/sdhci-of-arasan.c | 54 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c     | 12 +++++++++
 4 files changed, 110 insertions(+)

--
1.8.2.1
