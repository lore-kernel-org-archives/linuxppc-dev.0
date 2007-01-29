Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 0503CDE05F
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:11:55 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0TKBsX7003498
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:11:54 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0TKBrsB014667
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:11:53 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJs3RR014696
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:54:03 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 5F31C4B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:11:52 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKBqYq013496
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:11:52 -0600
Date: Mon, 29 Jan 2007 14:11:52 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/18] bootwrapper: Add stddef.h to ops.h
Message-ID: <20070129201152.GA13485@ld0162-tx32.am.freescale.net>
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

ops.h references NULL, so include stddef.h, so files including ops.h
don't have to.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/ops.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 8abb651..4ac7b02 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -11,6 +11,7 @@
 #ifndef _PPC_BOOT_OPS_H_
 #define _PPC_BOOT_OPS_H_
 
+#include <stddef.h>
 #include "types.h"
 
 #define	COMMAND_LINE_SIZE	512
-- 
1.4.4
