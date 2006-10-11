Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 55BB267A3A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 21:27:19 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k9BBRH5G026985
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 04:27:17 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k9BBRFnu009409
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 06:27:17 -0500 (CDT)
Message-ID: <452CD53D.7050501@freescale.com>
Date: Wed, 11 Oct 2006 19:27:57 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: Paul <paulus@samba.org>
Subject: [PATCH] Add Makefile entry for MPC832x_mds support
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

Add missing entry in Makefile for MPC832x MDS support.  It
also change white space to tab in MPC8360 entry.

Signed-off-by: Li Yang <leoli@freescale.com>
---

diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index e60fd75..f1aa7e2 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -5,4 +5,5 @@ obj-y				:= misc.o
 obj-$(CONFIG_PCI)		+= pci.o
 obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o
 obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
-obj-$(CONFIG_MPC8360E_PB)       += mpc8360e_pb.o
+obj-$(CONFIG_MPC8360E_PB)	+= mpc8360e_pb.o
+obj-$(CONFIG_MPC832x_MDS)	+= mpc832x_mds.o
