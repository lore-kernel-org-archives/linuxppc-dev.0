Message-ID: <3BB0D8B1.98ED1E7@highway.ne.jp>
Date: Wed, 26 Sep 2001 04:19:13 +0900
From: Kaoru Fukui <k_fukui@highway.ne.jp>
MIME-Version: 1.0
To: benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: Ben's 2.4.10 problems
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

I had problems in latest Ben's 2.4.10 compiling.
The problems are in 12c.c,smp.c,chrp_smp.c.

Kaoru

------------------------------------------
diff -urN base/drivers/i2c/i2c-keywest.c fixed/drivers/i2c/i2c-keywest.c

--- base/drivers/i2c/i2c-keywest.c Mon Sep 24 22:24:14 2001
+++ fixed/drivers/i2c/i2c-keywest.c Wed Sep 26 02:00:50 2001
@@ -42,7 +42,7 @@
 #include <linux/mm.h>

 #include <asm/prom.h>
-#include <asm/feature.h>
+#include <asm/pmac_feature.h>
 #include <linux/nvram.h>

 /* The Tumbler audio equalizer can be really slow sometimes */

------------------------------------------------
diff -urN base/arch/ppc/kernel/chrp_smp.c
fixed/arch/ppc/kernel/chrp_smp.c
--- base/arch/ppc/kernel/chrp_smp.c Mon Sep 24 22:24:23 2001
+++ fixed/arch/ppc/kernel/chrp_smp.c Wed Sep 26 02:43:21 2001
@@ -36,7 +36,7 @@
 #include <asm/prom.h>
 #include <asm/smp.h>
 #include <asm/residual.h>
-#include <asm/feature.h>
+#include <asm/pmac_feature.h>
 #include <asm/time.h>

 #include "open_pic.h"
diff -urN base/arch/ppc/kernel/smp.c fixed/arch/ppc/kernel/smp.c
--- base/arch/ppc/kernel/smp.c Mon Sep 24 22:24:23 2001
+++ fixed/arch/ppc/kernel/smp.c Wed Sep 26 02:22:28 2001
@@ -35,7 +35,7 @@
 #include <asm/prom.h>
 #include <asm/smp.h>
 #include <asm/residual.h>
-#include <asm/feature.h>
+#include <asm/pmac_feature.h>
 #include <asm/time.h>

 #include "open_pic.h"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
