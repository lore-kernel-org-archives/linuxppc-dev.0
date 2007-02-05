Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts5-srv.bellnexxia.net (tomts5.bellnexxia.net
	[209.226.175.25]) by ozlabs.org (Postfix) with ESMTP id 60589DDE27
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 07:20:14 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts5-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070205202011.MFJG5067.tomts5-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 15:20:11 -0500
Date: Mon, 5 Feb 2007 15:20:11 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH] powerpc 405 : remove 4xx platform from Makefile
Message-ID: <20070205202011.GA13694@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc 405 : remove 4xx platform from Makefile

Having an empty arch/powerpc/platforms/4xx (no object) causes a linking
error. To correct this, 4xx must be removed from the upper level
Makefile (just like 8xx).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/arch/powerpc/platforms/4xx/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-# empty makefile so make clean works
\ No newline at end of file
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makef=
ile
index 507d1b9..0db6cca 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -7,7 +7,6 @@ endif
 endif
 obj-$(CONFIG_PPC_MPC52xx)	+=3D 52xx/
 obj-$(CONFIG_PPC_CHRP)		+=3D chrp/
-obj-$(CONFIG_4xx)		+=3D 4xx/
 obj-$(CONFIG_PPC_83xx)		+=3D 83xx/
 obj-$(CONFIG_PPC_85xx)		+=3D 85xx/
 obj-$(CONFIG_PPC_86xx)		+=3D 86xx/
--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
