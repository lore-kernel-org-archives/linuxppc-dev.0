Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHmxP5pqWzF0cZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 13:32:41 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] powerpc: Remove DEBUG define in 64-bit early setup code
Date: Fri, 12 Jan 2018 13:28:46 +1100
Message-Id: <20180112022849.30899-2-benh@kernel.crashing.org>
In-Reply-To: <20180112022849.30899-1-benh@kernel.crashing.org>
References: <20180112022849.30899-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This statement causes some not very useful messages to always
be printed on the serial port at boot, even on quiet boots.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 8956a9856604..d3124c302146 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -10,8 +10,6 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#define DEBUG
-
 #include <linux/export.h>
 #include <linux/string.h>
 #include <linux/sched.h>
-- 
2.14.3
