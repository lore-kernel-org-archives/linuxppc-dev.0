Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C3A3967B84
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 08:46:33 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k57N3HvW000075
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 16:03:17 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k57MkWVq004604
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 17:46:32 -0500 (CDT)
Subject: [PATCH 7/10] Add use of mpc86xx.h include files in legacy header
	files.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1149720157.23938.202.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 07 Jun 2006 17:42:37 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

 include/asm-ppc/io.h      |    2 ++
 include/asm-ppc/ppc_sys.h |    2 ++
 include/asm-ppc/serial.h  |    2 ++
 3 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
index b919d8f..0802be9 100644
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -37,6 +37,8 @@ #elif defined(CONFIG_83xx)
 #include <asm/mpc83xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
+#elif defined(CONFIG_PPC_86xx)
+#include <asm/mpc86xx.h>
 #elif defined(CONFIG_APUS)
 #define _IO_BASE	0
 #define _ISA_MEM_BASE	0
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
index 40f197a..4eaf80d 100644
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -27,6 +27,8 @@ #elif defined(CONFIG_83xx)
 #include <asm/mpc83xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
+#elif defined(CONFIG_PPC_86xx)
+#include <asm/mpc86xx.h>
 #elif defined(CONFIG_8xx)
 #include <asm/mpc8xx.h>
 #elif defined(CONFIG_PPC_MPC52xx)
diff --git a/include/asm-ppc/serial.h b/include/asm-ppc/serial.h
index b74af54..e819250 100644
--- a/include/asm-ppc/serial.h
+++ b/include/asm-ppc/serial.h
@@ -36,6 +36,8 @@ #elif defined(CONFIG_83xx)
 #include <asm/mpc83xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
+#elif defined(CONFIG_PPC_86xx)
+#include <asm/mpc86xx.h>
 #elif defined(CONFIG_RADSTONE_PPC7D)
 #include <platforms/radstone_ppc7d.h>
 #else
