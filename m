Return-Path: <anton@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8288DB70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Mar 2011 23:00:37 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p25C0UxM021710
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 5 Mar 2011 23:00:30 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p25C0RIF2470052
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 5 Mar 2011 23:00:30 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p25C0RTH032673
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 5 Mar 2011 23:00:27 +1100
Date: Sat, 5 Mar 2011 23:00:26 +1100
From: Anton Blanchard <anton@au1.ibm.com>
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: Enable Chelsio network and iWARP drivers
Message-ID: <20110305230026.200454a7@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ensure the Chelsio T3/T4 network drivers and iWARP drivers are
enabled in the pseries config.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/pseries_defconfig	2011-03-05 22:58:38.886562678 +1100
+++ linux-2.6/arch/powerpc/configs/pseries_defconfig	2011-03-05 22:58:40.346615219 +1100
@@ -189,6 +189,7 @@ CONFIG_TIGON3=y
 CONFIG_BNX2=m
 CONFIG_CHELSIO_T1=m
 CONFIG_CHELSIO_T3=m
+CONFIG_CHELSIO_T4=m
 CONFIG_EHEA=y
 CONFIG_IXGBE=m
 CONFIG_IXGB=m
@@ -255,6 +256,8 @@ CONFIG_INFINIBAND_USER_MAD=m
 CONFIG_INFINIBAND_USER_ACCESS=m
 CONFIG_INFINIBAND_MTHCA=m
 CONFIG_INFINIBAND_EHCA=m
+CONFIG_INFINIBAND_CXGB3=m
+CONFIG_INFINIBAND_CXGB4=m
 CONFIG_MLX4_INFINIBAND=m
 CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_CM=y
