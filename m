Return-Path: <compudj@krystal.dyndns.org>
Received: from toq5-srv.bellnexxia.net (toq5.bellnexxia.net [209.226.175.27])
	by ozlabs.org (Postfix) with ESMTP id B8823DDF09
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 09:40:02 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts5-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070207221900.OJFS1671.tomts5-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-embedded@ozlabs.org>; Wed, 7 Feb 2007 17:19:00 -0500
Date: Wed, 7 Feb 2007 17:18:59 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: mporter@kernel.crashing.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] Undefined DCRN_CPMFR in include/asm-ppc/ocp.h
Message-ID: <20070207221859.GA22740@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Undefined DCRN_CPMFR in include/asm-ppc/ocp.h

There seems to be a missing #include <asm-ppc/io.h> in ocp.h, because it
needs DCRN_CPMFR to be defined. I get a compile error when compiling it
on PPC 405 with CONFIG_PM enabled. It applies on 2.6.20.

Mathieu

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-ppc/ocp.h
+++ b/include/asm-ppc/ocp.h
@@ -32,6 +32,7 @@
 #include <asm/ocp_ids.h>
 #include <asm/rwsem.h>
 #include <asm/semaphore.h>
+#include <asm-ppc/io.h>
=20
 #ifdef CONFIG_PPC_OCP
--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
