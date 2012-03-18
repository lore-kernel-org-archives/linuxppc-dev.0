Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EEE63B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 08:39:41 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: davem@davemloft.net, eric.dumazet@gmail.com, therbert@google.com
Subject: [PATCH net-next 2/4] gianfar: constify giant block of status
 descriptor strings
Date: Sun, 18 Mar 2012 17:39:19 -0400
Message-Id: <1332106761-18293-3-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1332106761-18293-1-git-send-email-paul.gortmaker@windriver.com>
References: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
 <1332106761-18293-1-git-send-email-paul.gortmaker@windriver.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/net/ethernet/freescale/gianfar_ethtool.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index 5a78d55..8d74efd 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -58,7 +58,7 @@ static void gfar_gringparam(struct net_device *dev, struct ethtool_ringparam *rv
 static int gfar_sringparam(struct net_device *dev, struct ethtool_ringparam *rvals);
 static void gfar_gdrvinfo(struct net_device *dev, struct ethtool_drvinfo *drvinfo);
 
-static char stat_gstrings[][ETH_GSTRING_LEN] = {
+static const char stat_gstrings[][ETH_GSTRING_LEN] = {
 	"rx-dropped-by-kernel",
 	"rx-large-frame-errors",
 	"rx-short-frame-errors",
-- 
1.7.9.1
