Return-Path: <r58472@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE8F82C0347
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2012 14:50:56 +1100 (EST)
From: Li Yang <leoli@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix typos in Freescale copyright claims
Date: Fri, 2 Nov 2012 12:53:42 +0800
Message-ID: <1351832022-23641-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are many cases that Semiconductor is misspelled.  The patch
fix these typos.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/include/asm/dbell.h          |    2 +-
 arch/powerpc/include/asm/fsl_gtm.h        |    2 +-
 arch/powerpc/include/asm/immap_qe.h       |    2 +-
 arch/powerpc/include/asm/ppc-opcode.h     |    2 +-
 arch/powerpc/include/asm/qe.h             |    2 +-
 arch/powerpc/include/asm/qe_ic.h          |    2 +-
 arch/powerpc/include/asm/ucc.h            |    2 +-
 arch/powerpc/include/asm/ucc_fast.h       |    2 +-
 arch/powerpc/include/asm/ucc_slow.h       |    2 +-
 arch/powerpc/platforms/52xx/lite5200.c    |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    2 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    2 +-
 arch/powerpc/platforms/83xx/mpc836x_rdk.c |    2 +-
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    2 +-
 arch/powerpc/sysdev/fsl_gtm.c             |    2 +-
 arch/powerpc/sysdev/qe_lib/qe.c           |    2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c        |    2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.h        |    2 +-
 arch/powerpc/sysdev/qe_lib/qe_io.c        |    2 +-
 arch/powerpc/sysdev/qe_lib/ucc.c          |    2 +-
 arch/powerpc/sysdev/qe_lib/ucc_fast.c     |    2 +-
 arch/powerpc/sysdev/qe_lib/ucc_slow.c     |    2 +-
 arch/powerpc/sysdev/qe_lib/usb.c          |    2 +-
 24 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 154c067..607e4ee 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2009 Freescale Semicondutor, Inc.
+ * Copyright 2009 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
diff --git a/arch/powerpc/include/asm/fsl_gtm.h b/arch/powerpc/include/asm/fsl_gtm.h
index 8e8c9b5..3b05808 100644
--- a/arch/powerpc/include/asm/fsl_gtm.h
+++ b/arch/powerpc/include/asm/fsl_gtm.h
@@ -1,7 +1,7 @@
 /*
  * Freescale General-purpose Timers Module
  *
- * Copyright (c) Freescale Semicondutor, Inc. 2006.
+ * Copyright 2006 Freescale Semiconductor, Inc.
  *               Shlomi Gridish <gridish@freescale.com>
  *               Jerry Huang <Chang-Ming.Huang@freescale.com>
  * Copyright (c) MontaVista Software, Inc. 2008.
diff --git a/arch/powerpc/include/asm/immap_qe.h b/arch/powerpc/include/asm/immap_qe.h
index 61e8490..bedbff8 100644
--- a/arch/powerpc/include/asm/immap_qe.h
+++ b/arch/powerpc/include/asm/immap_qe.h
@@ -3,7 +3,7 @@
  * The Internal Memory Map for devices with QE on them. This
  * is the superset of all QE devices (8360, etc.).
 
- * Copyright (C) 2006. Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2006. Freescale Semiconductor, Inc. All rights reserved.
  *
  * Authors: 	Shlomi Gridish <gridish@freescale.com>
  * 		Li Yang <leoli@freescale.com>
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 5f73ce6..be19698 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2009 Freescale Semicondutor, Inc.
+ * Copyright 2009 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index 229571a..32b9bfa 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Authors: 	Shlomi Gridish <gridish@freescale.com>
  * 		Li Yang <leoli@freescale.com>
diff --git a/arch/powerpc/include/asm/qe_ic.h b/arch/powerpc/include/asm/qe_ic.h
index f706164..25784cc 100644
--- a/arch/powerpc/include/asm/qe_ic.h
+++ b/arch/powerpc/include/asm/qe_ic.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Authors: 	Shlomi Gridish <gridish@freescale.com>
  * 		Li Yang <leoli@freescale.com>
diff --git a/arch/powerpc/include/asm/ucc.h b/arch/powerpc/include/asm/ucc.h
index 46b09ba..6927ac2 100644
--- a/arch/powerpc/include/asm/ucc.h
+++ b/arch/powerpc/include/asm/ucc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Authors: 	Shlomi Gridish <gridish@freescale.com>
  * 		Li Yang <leoli@freescale.com>
diff --git a/arch/powerpc/include/asm/ucc_fast.h b/arch/powerpc/include/asm/ucc_fast.h
index 4644c84..72ea9ba 100644
--- a/arch/powerpc/include/asm/ucc_fast.h
+++ b/arch/powerpc/include/asm/ucc_fast.h
@@ -1,7 +1,7 @@
 /*
  * Internal header file for UCC FAST unit routines.
  *
- * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Authors: 	Shlomi Gridish <gridish@freescale.com>
  * 		Li Yang <leoli@freescale.com>
diff --git a/arch/powerpc/include/asm/ucc_slow.h b/arch/powerpc/include/asm/ucc_slow.h
index cf131ff..c44131e 100644
--- a/arch/powerpc/include/asm/ucc_slow.h
+++ b/arch/powerpc/include/asm/ucc_slow.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Authors: 	Shlomi Gridish <gridish@freescale.com>
  * 		Li Yang <leoli@freescale.com>
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 448d862..1843bc9 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -4,7 +4,7 @@
  * Written by: Grant Likely <grant.likely@secretlab.ca>
  *
  * Copyright (C) Secret Lab Technologies Ltd. 2006. All rights reserved.
- * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ * Copyright 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Description:
  * This program is free software; you can redistribute  it and/or modify it
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index d440435..8d76220 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ * Copyright 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Description:
  * MPC832xE MDS board specific routines.
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 1b1f6c8..1a26d2f 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ * Copyright 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author: Li Yang <LeoLi@freescale.com>
  *	   Yin Olivia <Hong-hua.Yin@freescale.com>
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index f8769d7..b63b42d 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -1,7 +1,7 @@
 /*
  * MPC8360E-RDK board file.
  *
- * Copyright (c) 2006  Freescale Semicondutor, Inc.
+ * Copyright (c) 2006  Freescale Semiconductor, Inc.
  * Copyright (c) 2007-2008  MontaVista Software, Inc.
  *
  * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index eca1f09..9813c81 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -1,7 +1,7 @@
 /*
  * arch/powerpc/platforms/83xx/mpc837x_rdb.c
  *
- * Copyright (C) 2007 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
  *
  * MPC837x RDB board specific routines
  *
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 8498f73..bd12588 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2010, 2012 Freescale Semicondutor, Inc.
+ * Copyright (C) 2006-2010, 2012 Freescale Semiconductor, Inc.
  * All rights reserved.
  *
  * Author: Andy Fleming <afleming@freescale.com>
diff --git a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/fsl_gtm.c
index 02cf1e7..0eb871c 100644
--- a/arch/powerpc/sysdev/fsl_gtm.c
+++ b/arch/powerpc/sysdev/fsl_gtm.c
@@ -1,7 +1,7 @@
 /*
  * Freescale General-purpose Timers Module
  *
- * Copyright (c) Freescale Semicondutor, Inc. 2006.
+ * Copyright (c) Freescale Semiconductor, Inc. 2006.
  *               Shlomi Gridish <gridish@freescale.com>
  *               Jerry Huang <Chang-Ming.Huang@freescale.com>
  * Copyright (c) MontaVista Software, Inc. 2008.
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index b043675..238a07b 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2010 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2006-2010 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Authors: 	Shlomi Gridish <gridish@freescale.com>
  * 		Li Yang <leoli@freescale.com>
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 2fba6ef..b2b87c3 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -1,7 +1,7 @@
 /*
  * arch/powerpc/sysdev/qe_lib/qe_ic.c
  *
- * Copyright (C) 2006 Freescale Semicondutor, Inc.  All rights reserved.
+ * Copyright (C) 2006 Freescale Semiconductor, Inc.  All rights reserved.
  *
  * Author: Li Yang <leoli@freescale.com>
  * Based on code from Shlomi Gridish <gridish@freescale.com>
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.h b/arch/powerpc/sysdev/qe_lib/qe_ic.h
index c327872..efef7ab 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.h
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.h
@@ -3,7 +3,7 @@
  *
  * QUICC ENGINE Interrupt Controller Header
  *
- * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author: Li Yang <leoli@freescale.com>
  * Based on code from Shlomi Gridish <gridish@freescale.com>
diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index fd1a6c3..a88807b 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -3,7 +3,7 @@
  *
  * QE Parallel I/O ports configuration routines
  *
- * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ * Copyright 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author: Li Yang <LeoLi@freescale.com>
  * Based on code from Shlomi Gridish <gridish@freescale.com>
diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/arch/powerpc/sysdev/qe_lib/ucc.c
index 0467750..134b07d 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc.c
@@ -3,7 +3,7 @@
  *
  * QE UCC API Set - UCC specific routines implementations.
  *
- * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Authors: 	Shlomi Gridish <gridish@freescale.com>
  * 		Li Yang <leoli@freescale.com>
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index fba0244..cceb2e3 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Authors: 	Shlomi Gridish <gridish@freescale.com>
  * 		Li Yang <leoli@freescale.com>
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
index 524c0ea..1c062f4 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ * Copyright (C) 2006 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Authors: 	Shlomi Gridish <gridish@freescale.com>
  * 		Li Yang <leoli@freescale.com>
diff --git a/arch/powerpc/sysdev/qe_lib/usb.c b/arch/powerpc/sysdev/qe_lib/usb.c
index 9162828..27f23bd 100644
--- a/arch/powerpc/sysdev/qe_lib/usb.c
+++ b/arch/powerpc/sysdev/qe_lib/usb.c
@@ -1,7 +1,7 @@
 /*
  * QE USB routines
  *
- * Copyright (c) Freescale Semicondutor, Inc. 2006.
+ * Copyright 2006 Freescale Semiconductor, Inc.
  *               Shlomi Gridish <gridish@freescale.com>
  *               Jerry Huang <Chang-Ming.Huang@freescale.com>
  * Copyright (c) MontaVista Software, Inc. 2008.
-- 
1.5.4.3
