Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from SG2EHSOBE003.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 8D027DF0DC
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 06:19:13 +1000 (EST)
Message-ID: <48AC7C1D.5070509@am.sony.com>
Date: Wed, 20 Aug 2008 13:18:37 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 1/4] powerpc: Fix typo in pgtable-ppc64.h
References: <48AC78BA.3070902@am.sony.com>
In-Reply-To: <48AC78BA.3070902@am.sony.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a minor comment typo in pgtable-ppc64.h.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -100,7 +100,7 @@
 
 #define _PAGE_WRENABLE	(_PAGE_RW | _PAGE_DIRTY)
 
-/* __pgprot defined in arch/powerpc/incliude/asm/page.h */
+/* __pgprot defined in arch/powerpc/include/asm/page.h */
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED)
 
 #define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_RW | _PAGE_USER)

-- 
