Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0069.outbound.protection.outlook.com [104.47.37.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj5ZG74tpzDvHd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 03:13:42 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <scott.wood@nxp.com>, <mpe@ellerman.id.au>
Subject: [PATCH net v3 0/4] fsl/fman: fixes for ARM
Date: Mon, 19 Dec 2016 18:13:29 +0200
Message-ID: <1482164013-6111-1-git-send-email-madalin.bucur@nxp.com>
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
non PPC platforms.

Changes from v2: merged fsl/fman changes to avoid a point of failure
Changes from v1: unifying probing on all supported platforms

Madalin Bucur (4):
  fsl/fman: fix 1G support for QSGMII interfaces
  powerpc: fsl/fman: remove fsl,fman from of_device_ids[]
  fsl/fman: A007273 only applies to PPC SoCs
  fsl/fman: enable compilation on ARM64

 arch/powerpc/platforms/85xx/corenet_generic.c |  3 ---
 drivers/net/ethernet/freescale/fman/Kconfig   |  2 +-
 drivers/net/ethernet/freescale/fman/fman.c    | 16 ++++++++++++++++
 drivers/net/ethernet/freescale/fman/mac.c     |  1 +
 4 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.1.0
