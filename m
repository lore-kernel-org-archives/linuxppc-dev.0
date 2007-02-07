Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts20-srv.bellnexxia.net (tomts20.bellnexxia.net
	[209.226.175.74]) by ozlabs.org (Postfix) with ESMTP id F0EEBDDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Feb 2007 10:54:29 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts20-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070207235427.NPTG24907.tomts20-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-embedded@ozlabs.org>; Wed, 7 Feb 2007 18:54:27 -0500
Date: Wed, 7 Feb 2007 18:54:26 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: mporter@kernel.crashing.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] PPC : vgacon_remap_base should be exported for modules
Message-ID: <20070207235426.GB26092@Krystal>
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

PPC : vgacon_remap_base should be exported for modules (vga16fb needs
this).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -87,6 +87,7 @@ EXPORT_SYMBOL(ppc_do_canonicalize_irqs);
=20
 #ifdef CONFIG_VGA_CONSOLE
 unsigned long vgacon_remap_base;
+EXPORT_SYMBOL(vgacon_remap_base);
 #endif
=20
 struct machdep_calls ppc_md;
--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
