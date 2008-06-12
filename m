Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A511CDDEDD
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 23:40:43 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] cpm_uart: fix whitespace issues
Date: Thu, 12 Jun 2008 08:40:30 -0500
Message-Id: <1213278034-28552-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1213278034-28552-1-git-send-email-galak@kernel.crashing.org>
References: <1213278034-28552-1-git-send-email-galak@kernel.crashing.org>
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/serial/cpm_uart/cpm_uart.h      |    8 ++++----
 drivers/serial/cpm_uart/cpm_uart_core.c |    4 ++--
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |    2 +-
 drivers/serial/cpm_uart/cpm_uart_cpm1.h |    2 +-
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    6 +++---
 drivers/serial/cpm_uart/cpm_uart_cpm2.h |    2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
index 0cc39f8..3d07bec 100644
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -6,7 +6,7 @@
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
  *
  *  2006 (c) MontaVista Software, Inc.
- * 	Vitaly Bordug <vbordug@ru.mvista.com>
+ *	Vitaly Bordug <vbordug@ru.mvista.com>
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
@@ -28,7 +28,7 @@
 #define SERIAL_CPM_MAJOR	204
 #define SERIAL_CPM_MINOR	46
 
-#define IS_SMC(pinfo) 		(pinfo->flags & FLAG_SMC)
+#define IS_SMC(pinfo)		(pinfo->flags & FLAG_SMC)
 #define IS_DISCARDING(pinfo)	(pinfo->flags & FLAG_DISCARDING)
 #define FLAG_DISCARDING	0x00000004	/* when set, don't discard */
 #define FLAG_SMC	0x00000002
@@ -70,7 +70,7 @@ struct uart_cpm_port {
 	void			(*set_lineif)(struct uart_cpm_port *);
 	u8			brg;
 	uint			 dp_addr;
-	void 			*mem_addr;
+	void			*mem_addr;
 	dma_addr_t		 dma_addr;
 	u32			mem_size;
 	/* helpers */
@@ -79,7 +79,7 @@ struct uart_cpm_port {
 	/* Keep track of 'odd' SMC2 wirings */
 	int			is_portb;
 	/* wait on close if needed */
-	int 			wait_closing;
+	int			wait_closing;
 	/* value to combine with opcode to form cpm command */
 	u32			command;
 };
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index a19dc7e..b0104ca 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -13,7 +13,7 @@
  *  Copyright (C) 2004, 2007 Freescale Semiconductor, Inc.
  *            (C) 2004 Intracom, S.A.
  *            (C) 2005-2006 MontaVista Software, Inc.
- * 		Vitaly Bordug <vbordug@ru.mvista.com>
+ *		Vitaly Bordug <vbordug@ru.mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -1305,7 +1305,7 @@ static int __init cpm_uart_console_setup(struct console *co, char *options)
 		pdata = pdev->dev.platform_data;
 		if (pdata)
 			if (pdata->init_ioports)
-    	                	pdata->init_ioports(pdata);
+				pdata->init_ioports(pdata);
 
 		cpm_uart_drv_get_platform_data(pdev, 1);
 	}
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 74f1432..bec0c97 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -9,7 +9,7 @@
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
  *            (C) 2004 Intracom, S.A.
  *            (C) 2006 MontaVista Software, Inc.
- * 		Vitaly Bordug <vbordug@ru.mvista.com>
+ *		Vitaly Bordug <vbordug@ru.mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.h b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
index ddf46d3..b805698 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.h
@@ -2,7 +2,7 @@
  * linux/drivers/serial/cpm_uart/cpm_uart_cpm1.h
  *
  * Driver for CPM (SCC/SMC) serial ports
- * 
+ *
  * definitions for cpm1
  *
  */
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index bb862e2..e53524c 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -5,11 +5,11 @@
  *
  *  Maintainer: Kumar Gala (galak@kernel.crashing.org) (CPM2)
  *              Pantelis Antoniou (panto@intracom.gr) (CPM1)
- * 
+ *
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
  *            (C) 2004 Intracom, S.A.
  *            (C) 2006 MontaVista Software, Inc.
- * 		Vitaly Bordug <vbordug@ru.mvista.com>
+ *		Vitaly Bordug <vbordug@ru.mvista.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -273,7 +273,7 @@ void scc4_lineif(struct uart_cpm_port *pinfo)
 #endif
 
 /*
- * Allocate DP-Ram and memory buffers. We need to allocate a transmit and 
+ * Allocate DP-Ram and memory buffers. We need to allocate a transmit and
  * receive buffer descriptors from dual port ram, and a character
  * buffer area from host mem. If we are allocating for the console we need
  * to do it from bootmem
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.h b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
index 40006a7..a48b56e 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.h
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.h
@@ -2,7 +2,7 @@
  * linux/drivers/serial/cpm_uart/cpm_uart_cpm2.h
  *
  * Driver for CPM (SCC/SMC) serial ports
- * 
+ *
  * definitions for cpm2
  *
  */
-- 
1.5.5.1
