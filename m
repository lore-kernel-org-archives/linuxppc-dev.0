Return-Path: <olof@lixom.net>
Date: Mon, 17 Dec 2007 17:04:34 -0600
From: Olof Johansson <olof@lixom.net>
To: galak@kernel.crashing.org
Subject: [PATCH] [POWERPC] holly.c: Remove unneccessary include of linux/ide.h
Message-ID: <20071217230434.GB22779@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's nothing in holly.c that needs linux/ide.h, just remove it from
the list of includes.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: mm/arch/powerpc/platforms/embedded6xx/holly.c
===================================================================
--- mm.orig/arch/powerpc/platforms/embedded6xx/holly.c	2007-12-14 02:41:24.000000000 -0600
+++ mm/arch/powerpc/platforms/embedded6xx/holly.c	2007-12-14 02:42:11.000000000 -0600
@@ -20,7 +20,6 @@
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
-#include <linux/ide.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/serial.h>
