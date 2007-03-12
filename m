Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 16FE8DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:41:43 +1100 (EST)
Date: Mon, 12 Mar 2007 14:41:38 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 01/19] bootwrapper: Add stddef.h to ops.h
Message-ID: <20070312204138.GA28545@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
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

ops.h references NULL, so include stddef.h, so files including ops.h
don't have to.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/ops.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index cad4eee..2b569ad 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -11,6 +11,7 @@
 #ifndef _PPC_BOOT_OPS_H_
 #define _PPC_BOOT_OPS_H_
 
+#include <stddef.h>
 #include "types.h"
 
 #define	COMMAND_LINE_SIZE	512
-- 
1.5.0.3
