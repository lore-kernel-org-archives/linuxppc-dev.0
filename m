Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbJr23W8RzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 20:19:46 +1100 (AEDT)
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Thu, 31 Mar 2016 10:19:43 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, imunsie@au1.ibm.com, mikey@neuling.org,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH v3 1/2] powerpc: Define PVR value for POWER8NVL processor
Date: Thu, 31 Mar 2016 11:19:27 +0200
Message-Id: <1459415968-4890-1-git-send-email-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
V2:
  - New patch, added to patch set
V3:
  - no change

 arch/powerpc/include/asm/reg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index f5f4c66..cf09c6e 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1182,6 +1182,7 @@
 #define PVR_970GX	0x0045
 #define PVR_POWER7p	0x004A
 #define PVR_POWER8E	0x004B
+#define PVR_POWER8NVL	0x004C
 #define PVR_POWER8	0x004D
 #define PVR_BE		0x0070
 #define PVR_PA6T	0x0090
-- 
2.1.0
