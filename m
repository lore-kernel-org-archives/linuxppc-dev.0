Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0A5172C0482
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 17:17:18 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH 2/2] powerpc/85xx: remove the unneeded corenet_ds.h
Date: Thu, 12 Sep 2013 15:13:13 +0800
Message-ID: <1378969993-14991-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1378969993-14991-1-git-send-email-haokexin@gmail.com>
References: <1378969993-14991-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the patch (powerpc/85xx: introduce cornet_generic machine) this
file becomes useless. Just delete it.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/platforms/85xx/corenet_ds.h | 19 -------------------
 1 file changed, 19 deletions(-)
 delete mode 100644 arch/powerpc/platforms/85xx/corenet_ds.h

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.h b/arch/powerpc/platforms/85xx/corenet_ds.h
deleted file mode 100644
index ddd700b..0000000
--- a/arch/powerpc/platforms/85xx/corenet_ds.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Corenet based SoC DS Setup
- *
- * Copyright 2009 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#ifndef CORENET_DS_H
-#define CORENET_DS_H
-
-extern void __init corenet_ds_pic_init(void);
-extern void __init corenet_ds_setup_arch(void);
-extern int __init corenet_ds_publish_devices(void);
-
-#endif
-- 
1.8.3.1
