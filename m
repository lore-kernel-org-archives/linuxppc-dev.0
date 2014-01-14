Return-Path: <Dongsheng.Wang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8F6EF2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 19:03:13 +1100 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>, <benh@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/fsl: add E500MC and E5500 PVR define
Date: Tue, 14 Jan 2014 15:59:55 +0800
Message-ID: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: anton@enomsg.org, linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

E500MC and E5500 PVR will be used in subsequent save/restore core
state patches.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 62b114e..cd7b630 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1075,6 +1075,8 @@
 #define PVR_8560	0x80200000
 #define PVR_VER_E500V1	0x8020
 #define PVR_VER_E500V2	0x8021
+#define PVR_VER_E500MC	0x8023
+#define PVR_VER_E5500	0x8024
 #define PVR_VER_E6500	0x8040
 
 /*
-- 
1.8.5
