Return-Path: <justinmattock@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id A68FA1008C6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Dec 2010 11:09:45 +1100 (EST)
Received: by mail-gy0-f179.google.com with SMTP id 8so4993197gyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 16:09:45 -0800 (PST)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: trivial@kernel.org
Subject: [PATCH 5/5]drivers:staging:rtl8187se:r8180_core.c Typo change singal
	to signal
Date: Thu, 30 Dec 2010 16:09:44 -0800
Message-Id: <1293754184-1928-5-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1293754184-1928-4-git-send-email-justinmattock@gmail.com>
References: <1293754184-1928-1-git-send-email-justinmattock@gmail.com>
	<1293754184-1928-2-git-send-email-justinmattock@gmail.com>
	<1293754184-1928-3-git-send-email-justinmattock@gmail.com>
	<1293754184-1928-4-git-send-email-justinmattock@gmail.com>
Cc: gregkh@suse.de, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	"Justin P. Mattock" <justinmattock@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patches below fixes a typo "singal" to "signal". Please let me 
know if anything needs to be changed.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/staging/rtl8187se/r8180_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8187se/r8180_core.c b/drivers/staging/rtl8187se/r8180_core.c
index 70ab008..1ccae4b 100644
--- a/drivers/staging/rtl8187se/r8180_core.c
+++ b/drivers/staging/rtl8187se/r8180_core.c
@@ -1329,7 +1329,7 @@ u16 N_DBPSOfRate(u16 DataRate)
 }
 
 /*
- * For Netgear case, they want good-looking singal strength.
+ * For Netgear case, they want good-looking signal strength.
  */
 long NetgearSignalStrengthTranslate(long LastSS, long CurrSS)
 {
@@ -1625,7 +1625,7 @@ void rtl8180_rx(struct net_device *dev)
 				 * of correctness. */
 				PerformUndecoratedSignalSmoothing8185(priv, bCckRate);
 
-				/* For good-looking singal strength. */
+				/* For good-looking signal strength. */
 				SignalStrengthIndex = NetgearSignalStrengthTranslate(
 								priv->LastSignalStrengthInPercent,
 								priv->SignalStrength);
-- 
1.6.5.2.180.gc5b3e
