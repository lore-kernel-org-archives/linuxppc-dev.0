Return-Path: <mjw@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BDEDA67B24
	for <linuxppc-dev@ozlabs.org>; Thu,  4 May 2006 05:11:23 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k43JBJd3002088
	for <linuxppc-dev@ozlabs.org>; Wed, 3 May 2006 15:11:19 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k43JBI9g255620
	for <linuxppc-dev@ozlabs.org>; Wed, 3 May 2006 15:11:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k43JBINB004183
	for <linuxppc-dev@ozlabs.org>; Wed, 3 May 2006 15:11:18 -0400
Received: from sig-9-76-26-66.mts.ibm.com (sig-9-76-26-66.mts.ibm.com
	[9.76.26.66])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k43JBIMJ004165
	for <linuxppc-dev@ozlabs.org>; Wed, 3 May 2006 15:11:18 -0400
Subject: [PATCH] define defaultimage for pseries
From: Mike Wolf <mjw@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 03 May 2006 14:11:14 -0500
Message-Id: <1146683474.26128.4.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Need to define defaultimage in arch/powerpc/Makefile
so that make rpm will work.

Signed-off-by: Mike Wolf <mjw@us.ibm.com>

---
--- 21959/arch/powerpc/Makefile.orig	2006-05-03 12:40:00.648340168 -0500
+++ 21959/arch/powerpc/Makefile	2006-05-03 13:49:53.754321760 -0500
@@ -141,6 +141,7 @@
 # Default to zImage, override when needed
 defaultimage-y			:= zImage
 defaultimage-$(CONFIG_PPC_ISERIES) := vmlinux
+defaultimage-$(CONFIG_PPC_PSERIES) := vmlinux
 defaultimage-$(CONFIG_DEFAULT_UIMAGE) := uImage
 KBUILD_IMAGE := $(defaultimage-y)
 all: $(KBUILD_IMAGE)
