Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 884AF67BC6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 11:29:29 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org,
	paulus@samba.org
Subject: [PATCH] [POWERPC] Add missing EXPORTS for mpc52xx support
Date: Mon,  4 Dec 2006 17:29:12 -0700
Message-Id: <1165278553297-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/kernel/of_device.c              |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
index 5c65398..8a06724 100644
--- a/arch/powerpc/kernel/of_device.c
+++ b/arch/powerpc/kernel/of_device.c
@@ -122,6 +122,7 @@ void of_device_unregister(struct of_devi
 }
 
 
+EXPORT_SYMBOL(of_match_node);
 EXPORT_SYMBOL(of_match_device);
 EXPORT_SYMBOL(of_device_register);
 EXPORT_SYMBOL(of_device_unregister);
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 05b2144..8331ff4 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -43,6 +43,7 @@ mpc52xx_find_and_map(const char *compati
 
 	return ioremap((u32)regaddr64, (u32)size64);
 }
+EXPORT_SYMBOL(mpc52xx_find_and_map);
 
 
 /**
@@ -72,6 +73,7 @@ mpc52xx_find_ipb_freq(struct device_node
 
 	return p_ipb_freq ? *p_ipb_freq : 0;
 }
+EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
 
 
 void __init
-- 
1.4.3.rc2.g0503
