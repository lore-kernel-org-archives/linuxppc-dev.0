Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay1.sgi.com [192.48.179.29])
	by ozlabs.org (Postfix) with ESMTP id 4EC33B7349
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Aug 2011 13:32:42 +1000 (EST)
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>, "David S. Miller" <davem@davemloft.net>,
	Kumar Gala <galak@kernel.crashing.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	U Bhaskar-B22300 <B22300@freescale.com>
Subject: [PATCH v13 1/6] flexcan: Remove #include <mach/clock.h>
Date: Tue, 16 Aug 2011 22:32:19 -0500
Message-Id: <1313551944-28603-2-git-send-email-holt@sgi.com>
In-Reply-To: <1313551944-28603-1-git-send-email-holt@sgi.com>
References: <1313551944-28603-1-git-send-email-holt@sgi.com>
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
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

powerpc does not have a mach-####/clock.h.  When testing, I found neither
arm nor powerpc needed the mach/clock.h at all so I removed it.

Signed-off-by: Robin Holt <holt@sgi.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
Cc: U Bhaskar-B22300 <B22300@freescale.com>
Cc: socketcan-core@lists.berlios.de
Cc: netdev@vger.kernel.org
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
---
 drivers/net/can/flexcan.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1767811..586b2cd 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -35,8 +35,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-#include <mach/clock.h>
-
 #define DRV_NAME			"flexcan"
 
 /* 8 for RX fifo and 2 error handling */
-- 
1.7.2.1
