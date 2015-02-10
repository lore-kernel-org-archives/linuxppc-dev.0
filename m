Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 388211A0152
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:27:32 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 21:27:29 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id BA3F838C804A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 21:27:26 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2RQCJ28442848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 02:27:26 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RPBp007332
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 21:27:26 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 07/18] powerpc/powernv: make whitespace for OPAL_PM_* defines
 match firmware
Date: Tue, 10 Feb 2015 13:26:49 +1100
Message-Id: <1423535220-6322-8-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 7075f57..31b9656 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -157,10 +157,10 @@
 /* Flags set in power-mgmt nodes in device tree if
  * respective idle states are supported in the platform.
  */
-#define OPAL_PM_NAP_ENABLED	0x00010000
-#define OPAL_PM_SLEEP_ENABLED	0x00020000
-#define OPAL_PM_WINKLE_ENABLED	0x00040000
-#define OPAL_PM_SLEEP_ENABLED_ER1	0x00080000
+#define OPAL_PM_NAP_ENABLED		0x00010000
+#define OPAL_PM_SLEEP_ENABLED		0x00020000
+#define OPAL_PM_WINKLE_ENABLED		0x00040000
+#define OPAL_PM_SLEEP_ENABLED_ER1	0x00080000 /* with workaround */
 
 #ifndef __ASSEMBLY__
 
-- 
1.7.10.4
