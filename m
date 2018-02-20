Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmFGm3p7WzF19Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:12:32 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id x19so8212877plr.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 14:12:32 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/9] powerpc/64s: cputable add all POWER9 features to
 CPU_FTRS_ALWAYS
Date: Wed, 21 Feb 2018 05:08:24 +1000
Message-Id: <20180220190832.1872-2-npiggin@gmail.com>
In-Reply-To: <20180220190832.1872-1-npiggin@gmail.com>
References: <20180220190832.1872-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/cputable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a2c5c95882cf..1fb9b1ea4662 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -541,7 +541,7 @@ enum {
 	     CPU_FTRS_POWER6 & CPU_FTRS_POWER7 & CPU_FTRS_CELL & \
 	     CPU_FTRS_PA6T & CPU_FTRS_POWER8 & CPU_FTRS_POWER8E & \
 	     CPU_FTRS_POWER8_DD1 & ~CPU_FTR_HVMODE & CPU_FTRS_POSSIBLE & \
-	     CPU_FTRS_POWER9)
+	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD1 & CPU_FTRS_POWER9_DD2_1)
 #endif
 #else
 enum {
-- 
2.16.1
