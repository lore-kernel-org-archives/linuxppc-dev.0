Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1EADB6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Mar 2011 03:44:10 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: dtc: remove obsolete .gitignore entries
Date: Sat, 12 Mar 2011 17:44:10 +0100
Message-Id: <1299948250-32084-1-git-send-email-w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dtc was moved and .gitignores have been added to the new location. So, we can
delete the old, forgotten ones.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/boot/.gitignore         |    1 -
 arch/powerpc/boot/dtc-src/.gitignore |    3 ---
 2 files changed, 0 insertions(+), 4 deletions(-)
 delete mode 100644 arch/powerpc/boot/dtc-src/.gitignore

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 3d80c3e..12da77e 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -1,5 +1,4 @@
 addnote
-dtc
 empty.c
 hack-coff
 infblock.c
diff --git a/arch/powerpc/boot/dtc-src/.gitignore b/arch/powerpc/boot/dtc-src/.gitignore
deleted file mode 100644
index a7c3f94..0000000
--- a/arch/powerpc/boot/dtc-src/.gitignore
+++ /dev/null
@@ -1,3 +0,0 @@
-dtc-lexer.lex.c
-dtc-parser.tab.c
-dtc-parser.tab.h
-- 
1.7.2.3
