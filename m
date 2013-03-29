Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews01.kpnxchange.com (cpsmtpb-ews01.kpnxchange.com
 [213.75.39.4]) by ozlabs.org (Postfix) with ESMTP id 604732C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2013 08:02:19 +1100 (EST)
Message-ID: <1364590934.1345.92.camel@x61.thuisdomein>
Subject: [PATCH] powerpc: Fix typo "CONFIG_ICSWX_PID"
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Fri, 29 Mar 2013 22:02:14 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jimi Xenidis <jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested. As this typo was introduced in v3.3, with commit
9d670280908013004f173b2b86414d9b6918511b ("powerpc: Split ICSWX ACOP and
PID processing"), which actually added PPC_ICSWX_PID, this surely needs
testing.

 arch/powerpc/mm/icswx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/icswx.c b/arch/powerpc/mm/icswx.c
index 8cdbd86..915412e 100644
--- a/arch/powerpc/mm/icswx.c
+++ b/arch/powerpc/mm/icswx.c
@@ -67,7 +67,7 @@
 
 void switch_cop(struct mm_struct *next)
 {
-#ifdef CONFIG_ICSWX_PID
+#ifdef CONFIG_PPC_ICSWX_PID
 	mtspr(SPRN_PID, next->context.cop_pid);
 #endif
 	mtspr(SPRN_ACOP, next->context.acop);
-- 
1.7.11.7
