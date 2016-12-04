Return-Path: <fabf@skynet.be>
Received: from mailrelay110.isp.belgacom.be (mailrelay110.isp.belgacom.be
 [195.238.20.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tWnjL6Kt4zDqck
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Dec 2016 23:47:34 +1100 (AEDT)
From: Fabian Frederick <fabf@skynet.be>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, fabf@skynet.be
Subject: [PATCH 1/1 linux-next] powerpc/fsl-lbc: use DEFINE_SPINLOCK()
Date: Sun,  4 Dec 2016 13:47:28 +0100
Message-Id: <1480855648-19747-1-git-send-email-fabf@skynet.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/powerpc/sysdev/fsl_lbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index 424b67f..5340a48 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -31,7 +31,7 @@
 #include <asm/prom.h>
 #include <asm/fsl_lbc.h>
 
-static spinlock_t fsl_lbc_lock = __SPIN_LOCK_UNLOCKED(fsl_lbc_lock);
+static DEFINE_SPINLOCK(fsl_lbc_lock);
 struct fsl_lbc_ctrl *fsl_lbc_ctrl_dev;
 EXPORT_SYMBOL(fsl_lbc_ctrl_dev);
 
-- 
2.7.4
