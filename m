Return-Path: <dwm@austin.ibm.com>
Received: from willy.enoyolf.org (willy.enoyolf.org [24.173.215.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "willy.enoyolf.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 583A9DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 13:23:42 +1100 (EST)
From: Doug Maxey <dwm@austin.ibm.com>
To: Jeff Garzik <jgarzik@garzik.org>
Subject: [PATCH 1/5] ehea: fix ehea.h checkpatch complaints
Date: Thu, 31 Jan 2008 20:20:47 -0600
Message-Id: <1201832451-23634-2-git-send-email-dwm@austin.ibm.com>
In-Reply-To: <1201832451-23634-1-git-send-email-dwm@austin.ibm.com>
References: <1201832451-23634-1-git-send-email-dwm@austin.ibm.com>
Cc: Linux PowerPC List <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Jan-Bernd Themann <themann@de.ibm.com>
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
 drivers/net/ehea/ehea.h    |    3 +++
 drivers/net/ehea/ehea_hw.h |    8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index 5f82a46..88fb53e 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -458,4 +458,7 @@ void ehea_set_ethtool_ops(struct net_device *netdev);
 int ehea_sense_port_attr(struct ehea_port *port);
 int ehea_set_portspeed(struct ehea_port *port, u32 port_speed);
 
+extern u64 ehea_driver_flags;
+extern struct work_struct ehea_rereg_mr_task;
+
 #endif	/* __EHEA_H__ */
diff --git a/drivers/net/ehea/ehea_hw.h b/drivers/net/ehea/ehea_hw.h
index 1af7ca4..567981b 100644
--- a/drivers/net/ehea/ehea_hw.h
+++ b/drivers/net/ehea/ehea_hw.h
@@ -29,10 +29,10 @@
 #ifndef __EHEA_HW_H__
 #define __EHEA_HW_H__
 
-#define QPX_SQA_VALUE   EHEA_BMASK_IBM(48,63)
-#define QPX_RQ1A_VALUE  EHEA_BMASK_IBM(48,63)
-#define QPX_RQ2A_VALUE  EHEA_BMASK_IBM(48,63)
-#define QPX_RQ3A_VALUE  EHEA_BMASK_IBM(48,63)
+#define QPX_SQA_VALUE   EHEA_BMASK_IBM(48, 63)
+#define QPX_RQ1A_VALUE  EHEA_BMASK_IBM(48, 63)
+#define QPX_RQ2A_VALUE  EHEA_BMASK_IBM(48, 63)
+#define QPX_RQ3A_VALUE  EHEA_BMASK_IBM(48, 63)
 
 #define QPTEMM_OFFSET(x) offsetof(struct ehea_qptemm, x)
 
-- 
1.5.3.8
