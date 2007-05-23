Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 195EDDDF4E
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 03:28:05 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4NHS1M6027236
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:28:01 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4NHS15T530258
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:28:01 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4NHS1P3031204
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:28:01 -0400
Date: Wed, 23 May 2007 12:28:01 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/4] powerpc: tweak EEH copyright info
Message-ID: <20070523172801.GD32380@austin.ibm.com>
References: <20070523171328.GY5921@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070523171328.GY5921@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Twiddle the copyright notices. Per current guidelines, the use
of the (C) or (c) in source code is deprecated. 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c        |    6 +++++-
 arch/powerpc/platforms/pseries/eeh_cache.c  |    3 ++-
 arch/powerpc/platforms/pseries/eeh_driver.c |    6 +++---
 3 files changed, 10 insertions(+), 5 deletions(-)

Index: linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.22-rc1.orig/arch/powerpc/platforms/pseries/eeh.c	2007-05-23 11:44:52.000000000 -0500
+++ linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh.c	2007-05-23 11:54:06.000000000 -0500
@@ -1,6 +1,8 @@
 /*
  * eeh.c
- * Copyright (C) 2001 Dave Engebretsen & Todd Inglett IBM Corporation
+ * Copyright IBM Corporation 2001, 2005, 2006
+ * Copyright Dave Engebretsen & Todd Inglett 2001
+ * Copyright Linas Vepstas 2005, 2006
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -15,6 +17,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * Please address comments and feedback to Linas Vepstas <linas@austin.ibm.com>
  */
 
 #include <linux/delay.h>
Index: linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh_cache.c
===================================================================
--- linux-2.6.22-rc1.orig/arch/powerpc/platforms/pseries/eeh_cache.c	2007-05-23 11:44:43.000000000 -0500
+++ linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh_cache.c	2007-05-23 11:54:31.000000000 -0500
@@ -2,7 +2,8 @@
  * eeh_cache.c
  * PCI address cache; allows the lookup of PCI devices based on I/O address
  *
- * Copyright (C) 2004 Linas Vepstas <linas@austin.ibm.com> IBM Corporation
+ * Copyright IBM Corporation 2004
+ * Copyright Linas Vepstas <linas@austin.ibm.com> 2004
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
Index: linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.22-rc1.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-05-23 11:43:44.000000000 -0500
+++ linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh_driver.c	2007-05-23 11:52:51.000000000 -0500
@@ -1,6 +1,7 @@
 /*
  * PCI Error Recovery Driver for RPA-compliant PPC64 platform.
- * Copyright (C) 2004, 2005 Linas Vepstas <linas@linas.org>
+ * Copyright IBM Corp. 2004 2005
+ * Copyright Linas Vepstas <linas@linas.org> 2004, 2005
  *
  * All rights reserved.
  *
@@ -19,8 +20,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * Send feedback to <linas@us.ibm.com>
- *
+ * Send comments and feedback to Linas Vepstas <linas@austin.ibm.com>
  */
 #include <linux/delay.h>
 #include <linux/interrupt.h>
