Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59C06DDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 01:13:48 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l6UFCjwN005070
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 19:12:45 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l6UFCjZY005067
	for linuxppc-dev@ozlabs.org; Mon, 30 Jul 2007 19:12:45 +0400
Date: Mon, 30 Jul 2007 19:12:45 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/6] PowerPC 440EPx: 440EPx/440EP dcr defines
Message-ID: <20070730151245.GA5027@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds DCR defines needed for 440EP/440EPx clock initialization.
These defines have been introduced in the Bamboo support by Josh Boyer
and are needed for Sequoia as well.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/boot/dcr.h |   11 +++++++++++
 1 files changed, 11 insertions(+)

diff -ruN linux.orig/arch/powerpc/boot/dcr.h linux/arch/powerpc/boot/dcr.h
--- linux.orig/arch/powerpc/boot/dcr.h	2007-07-27 20:37:10.000000000 +0400
+++ linux/arch/powerpc/boot/dcr.h	2007-07-27 21:06:11.000000000 +0400
@@ -121,4 +121,15 @@
 #define DCRN_CPC0_MIRQ1					0x0ed
 #define DCRN_CPC0_JTAGID				0x0ef
 
+/* 440EP/440EPx  Clock/Power-on Reset regs */
+#define DCRN_CPR0_ADDR	0xc
+#define DCRN_CPR0_DATA	0xd
+#define CPR0_PLLD0	0x60
+#define CPR0_OPBD0	0xc0
+#define CPR0_PERD0	0xe0
+#define CPR0_PRIMBD0	0xa0
+#define CPR0_SCPID	0x120
+#define CPR0_PLLC0	0x40
+
+
 #endif	/* _PPC_BOOT_DCR_H_ */
