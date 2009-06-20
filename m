Return-Path: <weiyi.huang@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8A904B7253
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 21:24:08 +1000 (EST)
Received: from mail-pz0-f175.google.com (mail-pz0-f175.google.com
	[209.85.222.175]) by ozlabs.org (Postfix) with ESMTP id F3888DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 21:24:06 +1000 (EST)
Received: by pzk5 with SMTP id 5so1254664pzk.17
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 04:24:05 -0700 (PDT)
From: Huang Weiyi <weiyi.huang@gmail.com>
To: galak@kernel.crashing.org
Subject: [PATCH 4/4] powerpc/85xx: remove duplicated #include
Date: Sat, 20 Jun 2009 19:16:59 +0800
Message-Id: <1245496619-2784-1-git-send-email-weiyi.huang@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Huang Weiyi <weiyi.huang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove duplicated #include in arch/powerpc/platforms/85xx/xes_mpc85xx.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/powerpc/platforms/85xx/xes_mpc85xx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index ee01532..1b42605 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -32,7 +32,6 @@
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <linux/of_platform.h>
 
 /* A few bit definitions needed for fixups on some boards */
 #define MPC85xx_L2CTL_L2E		0x80000000 /* L2 enable */
-- 
1.6.1.2
