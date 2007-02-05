Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts16-srv.bellnexxia.net (tomts16.bellnexxia.net
	[209.226.175.4]) by ozlabs.org (Postfix) with ESMTP id AFCA1DDE29
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 01:29:08 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts16-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070205142905.WBHG12977.tomts16-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 09:29:05 -0500
Date: Mon, 5 Feb 2007 09:29:05 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Missing include in include/asm-powerpc/prom.h
Message-ID: <20070205142905.GA31392@Krystal>
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

Missing include in include/asm-powerpc/prom.h

include/asm-powerpc/prom.h needs to include asm/irq.h because it uses
irq_of_parse_and_map and NO_IRQ. It applies on 2.6.20.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -19,6 +19,7 @@
 #include <linux/proc_fs.h>
 #include <linux/platform_device.h>
 #include <asm/atomic.h>
+#include <asm/irq.h>
 
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
