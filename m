Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 7CB79DE010
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:05 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0OL6xeh018197
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:06:59 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0OL6wsi013059
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:06:59 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnLZf008095
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:22 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 316C14B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:06:58 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL6wRO010553
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:06:58 -0600
Date: Wed, 24 Jan 2007 15:06:58 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/18] Add stddef.h to arch/powerpc/boot/ops.h
Message-ID: <20070124210658.GB10527@ld0162-tx32.am.freescale.net>
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
