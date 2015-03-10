Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08FDD1A0629
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 04:38:46 +1100 (AEDT)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/fsl-booke: Add T4080 SVR value
Date: Tue, 10 Mar 2015 15:19:42 +0200
Message-ID: <1425993582-21754-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Madalin Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madalin Bucur <madalin.bucur@freescale.com>

Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
---
 arch/powerpc/include/asm/mpc85xx.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/mpc85xx.h b/arch/powerpc/include/asm/mpc85xx.h
index 3bef74a..213f3a8 100644
--- a/arch/powerpc/include/asm/mpc85xx.h
+++ b/arch/powerpc/include/asm/mpc85xx.h
@@ -61,6 +61,7 @@
 #define SVR_T4240	0x824000
 #define SVR_T4120	0x824001
 #define SVR_T4160	0x824100
+#define SVR_T4080	0x824102
 #define SVR_C291	0x850000
 #define SVR_C292	0x850020
 #define SVR_C293	0x850030
-- 
1.7.9.5
