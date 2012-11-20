Return-Path: <tushar.behera@linaro.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B2F7A2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 15:38:08 +1100 (EST)
Received: by mail-da0-f51.google.com with SMTP id i30so741627dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 20:38:05 -0800 (PST)
From: Tushar Behera <tushar.behera@linaro.org>
To: linuxppc-dev@lists.ozlabs.org,
	devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/85xx: p1022ds: Use NULL instead of 0 for pointers
Date: Tue, 20 Nov 2012 10:01:51 +0530
Message-Id: <1353385912-25882-1-git-send-email-tushar.behera@linaro.org>
Cc: patches@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The third argument for of_get_property() is a pointer, hence pass
NULL instead of 0.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/powerpc/platforms/85xx/p1022_ds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 8fb1257..7328b8d 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -249,7 +249,7 @@ static void p1022ds_set_monitor_port(enum fsl_diu_monitor_port port)
 		goto exit;
 	}
 
-	iprop = of_get_property(law_node, "fsl,num-laws", 0);
+	iprop = of_get_property(law_node, "fsl,num-laws", NULL);
 	if (!iprop) {
 		pr_err("p1022ds: LAW node is missing fsl,num-laws property\n");
 		goto exit;
-- 
1.7.4.1
