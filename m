Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 522A52BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 13:54:48 +1000 (EST)
Date: Fri, 8 Oct 2004 20:54:43 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20041008205443.A18025@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Add gen550.h
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add a missing include file for gen550.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff -Nru a/arch/ppc/syslib/gen550.h b/arch/ppc/syslib/gen550.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/gen550.h	2004-10-08 20:50:13 -07:00
@@ -0,0 +1,16 @@
+/*
+ * arch/ppc/syslib/gen550.h
+ *
+ * gen550 prototypes
+ *
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * 2004 (c) MontaVista Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+extern void gen550_progress(char *, unsigned short);
+extern void gen550_init(int, struct uart_port *);
+extern void gen550_kgdb_map_scc(void);
