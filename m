Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id 47638B7AFA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Aug 2011 18:46:35 +1000 (EST)
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>, Kumar Gala <galak@kernel.crashing.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	U Bhaskar-B22300 <B22300@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v12 6/6] powerpc: Add flexcan device support for p1010rdb.
Date: Fri, 12 Aug 2011 03:45:52 -0500
Message-Id: <1313138752-24006-7-git-send-email-holt@sgi.com>
In-Reply-To: <1313138752-24006-1-git-send-email-holt@sgi.com>
References: <1313138752-24006-1-git-send-email-holt@sgi.com>
Cc: , netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow the p1010 processor to select the flexcan network driver.

Signed-off-by: Robin Holt <holt@sgi.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>,
Acked-by: Wolfgang Grandegger <wg@grandegger.com>,
Cc: U Bhaskar-B22300 <B22300@freescale.com>
Cc: socketcan-core@lists.berlios.de,
Cc: netdev@vger.kernel.org,
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6926b61..47682b6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -656,6 +656,8 @@ config SBUS
 
 config FSL_SOC
 	bool
+	select HAVE_CAN_FLEXCAN if NET && CAN
+	select PPC_CLOCK if CAN_FLEXCAN
 
 config FSL_PCI
  	bool
-- 
1.7.2.1
