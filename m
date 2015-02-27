Return-Path: <yguerrini@purch.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0111.outbound.protection.outlook.com [207.46.100.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A95D11A0052
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2015 09:39:26 +1100 (AEDT)
From: Yannick Guerrini <yguerrini@tomshardware.fr>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix trivial typo in comment
Date: Fri, 27 Feb 2015 23:22:54 +0100
Message-ID: <1425075774-15308-1-git-send-email-yguerrini@tomshardware.fr>
MIME-Version: 1.0
Content-Type: text/plain
Cc: trivial@kernel.org, Yannick
 Guerrini <yguerrini@tomshardware.fr>, linux-kernel@vger.kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change 'Kenrel' to 'Kernel'

Signed-off-by: Yannick Guerrini <yguerrini@tomshardware.fr>
---
 arch/powerpc/include/asm/smu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/smu.h b/arch/powerpc/include/asm/smu.h
index 6e909f3..37d2da6 100644
--- a/arch/powerpc/include/asm/smu.h
+++ b/arch/powerpc/include/asm/smu.h
@@ -478,7 +478,7 @@ extern unsigned long smu_cmdbuf_abs;
 
 
 /*
- * Kenrel asynchronous i2c interface
+ * Kernel asynchronous i2c interface
  */
 
 #define SMU_I2C_READ_MAX	0x1d
-- 
1.9.5.msysgit.0
