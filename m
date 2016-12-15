Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0073.outbound.protection.outlook.com [104.47.36.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfYkC1862zDvjw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 00:11:46 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>
Subject: [PATCH net 0/4] fsl/fman: fixes for ARM 
Date: Thu, 15 Dec 2016 15:11:33 +0200
Message-ID: <1481807497-4724-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch set fixes advertised speeds for QSGMII interfaces, disables
A007273 erratum workaround on non-PowerPC platforms where it does not
apply, enables compilation on ARM64 and addresses a probing issue on
ARM64.

Igal Liberman (1):
  fsl/fman: arm: call of_platform_populate() for arm64 platfrom

Madalin Bucur (3):
  fsl/fman: fix 1G support for QSGMII interfaces
  fsl/fman: A007273 only applies to PPC SoCs
  fsl/fman: enable compilation on ARM64

 drivers/net/ethernet/freescale/fman/Kconfig |  2 +-
 drivers/net/ethernet/freescale/fman/fman.c  | 18 ++++++++++++++++++
 drivers/net/ethernet/freescale/fman/mac.c   |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.1.0
