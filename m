Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 31345DDEF3
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 16:32:02 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0U5Vv7D004374
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 22:31:57 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0U5Vo7W001893
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 23:31:52 -0600 (CST)
Message-ID: <45BED88D.2050908@freescale.com>
Date: Tue, 30 Jan 2007 13:33:01 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH] powerpc: include new of_platform.h for 836x and 832x
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some prototypes are separated from of_device.h into of_platform.h.  Add
the new include to fix warning. 

Signed-off-by: Li Yang <leoli@freescale.com> 
---
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    1 +
 arch/powerpc/platforms/83xx/mpc8360e_pb.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 4d47119..2c7a1e9 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -25,6 +25,7 @@
 #include <linux/initrd.h>
 
 #include <asm/of_device.h>
+#include <asm/of_platform.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.c b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
index 53b92a9..a1e23f0 100644
--- a/arch/powerpc/platforms/83xx/mpc8360e_pb.c
+++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
@@ -31,6 +31,7 @@
 #include <linux/initrd.h>
 
 #include <asm/of_device.h>
+#include <asm/of_platform.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
