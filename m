Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 77DBB67C18
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2005 05:37:31 +1000 (EST)
Date: Sun, 10 Jul 2005 17:37:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: paulus@samba.org
Message-ID: <20050710153722.GM28243@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/ppc/kernel/ppc_ksyms.c: remove unused #define
	EXPORT_SYMTAB_STROPS
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This #define is only used on sparc.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc2-mm1-full/arch/ppc/kernel/ppc_ksyms.c.old	2005-07-10 17:35:05.000000000 +0200
+++ linux-2.6.13-rc2-mm1-full/arch/ppc/kernel/ppc_ksyms.c	2005-07-10 17:35:12.000000000 +0200
@@ -51,9 +51,6 @@
 #include <asm/commproc.h>
 #endif
 
-/* Tell string.h we don't want memcpy etc. as cpp defines */
-#define EXPORT_SYMTAB_STROPS
-
 extern void transfer_to_handler(void);
 extern void do_IRQ(struct pt_regs *regs);
 extern void MachineCheckException(struct pt_regs *regs);
