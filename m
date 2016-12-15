Return-Path: <madalin.bucur@nxp.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0068.outbound.protection.outlook.com [104.47.33.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfYlv1vLczDwBZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 00:13:15 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>
Subject: [PATCH net 0/3] dpaa_eth: a couple of fixes 
Date: Thu, 15 Dec 2016 15:13:03 +0200
Message-ID: <1481807586-4798-1-git-send-email-madalin.bucur@nxp.com>
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

This patch set introduces big endian accessors in the dpaa_eth driver
making sure accesses to the QBMan HW are correct on little endian
platforms. Removing a redundant Kconfig dependency on FSL_SOC.
Adding myself as maintainer of the dpaa_eth driver.

Claudiu Manoil (1):
  dpaa_eth: use big endian accessors

Madalin Bucur (2):
  dpaa_eth: remove redundant dependency on FSL_SOC
  MAINTAINERS: net: add entry for Freescale QorIQ DPAA Ethernet driver

 MAINTAINERS                                    |  6 +++
 drivers/net/ethernet/freescale/dpaa/Kconfig    |  2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 71 ++++++++++++++------------
 3 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.1.0
