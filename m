Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
 by lists.ozlabs.org (Postfix) with ESMTP id 5B10B1A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 03:29:22 +1100 (AEDT)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
 by winston.telenet-ops.be (Postfix) with ESMTP id 0577E1BC31F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 17:29:18 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <trivial@kernel.org>
Subject: [PATCH trivial] powerpc: Spelling s/embeeded/embedded/
Date: Wed, 18 Mar 2015 17:29:13 +0100
Message-Id: <1426696153-22070-1-git-send-email-geert+renesas@glider.be>
Cc: linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/powerpc/platforms/Kconfig.cputype | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 76483e3acd60e432..0e1a6ce270086d1c 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -15,7 +15,7 @@ choice
 	  The most common ones are the desktop and server CPUs (601, 603,
 	  604, 740, 750, 74xx) CPUs from Freescale and IBM, with their
 	  embedded 512x/52xx/82xx/83xx/86xx counterparts.
-	  The other embeeded parts, namely 4xx, 8xx, e200 (55xx) and e500
+	  The other embedded parts, namely 4xx, 8xx, e200 (55xx) and e500
 	  (85xx) each form a family of their own that is not compatible
 	  with the others.
 
-- 
1.9.1
