Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>
Subject: [PATCH 3/9] drivers/net: typo fix of faild to failed
Date: Thu, 21 Oct 2010 22:17:14 -0700
Message-Id: <246fa5db6273b9f79c3bb27ab2abb22e85fe7b38.1287724261.git.joe@perches.com>
In-Reply-To: <cover.1287724261.git.joe@perches.com>
References: <cover.1287724261.git.joe@perches.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Grant Grundler <grundler@parisc-linux.org>,
	Geoff Levand <geoff@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ps3_gelic_net.c |    4 ++--
 drivers/net/tulip/pnic2.c   |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ps3_gelic_net.c b/drivers/net/ps3_gelic_net.c
index 87d6b8f..49f6700 100644
--- a/drivers/net/ps3_gelic_net.c
+++ b/drivers/net/ps3_gelic_net.c
@@ -642,7 +642,7 @@ static inline void gelic_card_disable_rxdmac(struct gelic_card *card)
 	status = lv1_net_stop_rx_dma(bus_id(card), dev_id(card), 0);
 	if (status)
 		dev_err(ctodev(card),
-			"lv1_net_stop_rx_dma faild, %d\n", status);
+			"lv1_net_stop_rx_dma failed, %d\n", status);
 }
 
 /**
@@ -660,7 +660,7 @@ static inline void gelic_card_disable_txdmac(struct gelic_card *card)
 	status = lv1_net_stop_tx_dma(bus_id(card), dev_id(card), 0);
 	if (status)
 		dev_err(ctodev(card),
-			"lv1_net_stop_tx_dma faild, status=%d\n", status);
+			"lv1_net_stop_tx_dma failed, status=%d\n", status);
 }
 
 /**
diff --git a/drivers/net/tulip/pnic2.c b/drivers/net/tulip/pnic2.c
index b819766..186d725 100644
--- a/drivers/net/tulip/pnic2.c
+++ b/drivers/net/tulip/pnic2.c
@@ -59,7 +59,7 @@
  * Bit 14:12 - autonegotiation state (write 001 to start autonegotiate)
  * Bit 3     - Autopolarity state
  * Bit 2     - LS10B - link state of 10baseT 0 - good, 1 - failed
- * Bit 1     - LS100B - link state of 100baseT 0 - good, 1- faild
+ * Bit 1     - LS100B - link state of 100baseT 0 - good, 1- failed
  *
  *
  * Data Port Selection Info
-- 
1.7.3.1.g432b3.dirty
