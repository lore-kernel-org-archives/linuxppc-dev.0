Return-Path: <dwm@austin.ibm.com>
Received: from willy.enoyolf.org (willy.enoyolf.org [24.173.215.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "willy.enoyolf.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 90A24DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 18:48:43 +1100 (EST)
From: Doug Maxey <dwm@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] ehea: fix ethtool checkpatch complaints
Date: Tue, 29 Jan 2008 00:50:56 -0600
Message-Id: <1201589459-30598-3-git-send-email-dwm@austin.ibm.com>
In-Reply-To: <1201589459-30598-1-git-send-email-dwm@austin.ibm.com>
References: <1201589459-30598-1-git-send-email-dwm@austin.ibm.com>
Cc: Jan-Bernd Themann <themann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cc: Jan-Bernd Themann <themann@de.ibm.com>
Signed-off-by: Doug Maxey <dwm@austin.ibm.com>
---
 drivers/net/ehea/ehea_ethtool.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ehea/ehea_ethtool.c b/drivers/net/ehea/ehea_ethtool.c
index 679f40e..d768852 100644
--- a/drivers/net/ehea/ehea_ethtool.c
+++ b/drivers/net/ehea/ehea_ethtool.c
@@ -40,7 +40,7 @@ static int ehea_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 		return ret;
 
 	if (netif_carrier_ok(dev)) {
-		switch(port->port_speed) {
+		switch (port->port_speed) {
 		case EHEA_SPEED_10M: cmd->speed = SPEED_10; break;
 		case EHEA_SPEED_100M: cmd->speed = SPEED_100; break;
 		case EHEA_SPEED_1G: cmd->speed = SPEED_1000; break;
@@ -78,7 +78,7 @@ static int ehea_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 		goto doit;
 	}
 
-	switch(cmd->speed) {
+	switch (cmd->speed) {
 	case SPEED_10:
 		if (cmd->duplex == DUPLEX_FULL)
 			sp = H_SPEED_10M_F;
-- 
1.5.3.7
