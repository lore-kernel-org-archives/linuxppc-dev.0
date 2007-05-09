Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 047C1DDEFB
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 02:20:55 +1000 (EST)
Date: Thu, 10 May 2007 02:21:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] We don't define CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
Message-Id: <20070510022100.ffd68cf2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

so this declaration is not needed.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/mmzone.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/mmzone.h b/include/asm-powerpc/mmzone.h
index d484ca9..19f299b 100644
--- a/include/asm-powerpc/mmzone.h
+++ b/include/asm-powerpc/mmzone.h
@@ -43,9 +43,5 @@ extern unsigned long max_pfn;
 
 #endif /* CONFIG_NEED_MULTIPLE_NODES */
 
-#ifdef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
-extern int __init early_pfn_to_nid(unsigned long pfn);
-#endif
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_MMZONE_H_ */
-- 
1.5.1.3
