Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 880DEDDF3C
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 03:57:38 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l86HvYhf003090
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 13:57:34 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l86HuFxL381102
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 11:57:34 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l86HlTA7018009
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 11:47:29 -0600
Date: Thu, 6 Sep 2007 12:47:29 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/3] powerpc: setup_64 comment cleanup.
Message-ID: <20070906174729.GC21800@austin.ibm.com>
References: <20070906174416.GW4584@austin.ibm.com>
	<20070906174521.GA21800@austin.ibm.com>
	<20070906174615.GB21800@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070906174615.GB21800@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Gramatical corrections to comments.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----

 arch/powerpc/kernel/prom.c     |    8 +++++---
 arch/powerpc/kernel/setup_64.c |    6 +++---
 2 files changed, 8 insertions(+), 6 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/kernel/setup_64.c	2007-09-04 17:29:36.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/kernel/setup_64.c	2007-09-05 14:12:23.000000000 -0500
@@ -181,9 +181,9 @@ void __init early_setup(unsigned long dt
  	DBG(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
 
 	/*
-	 * Do early initializations using the flattened device
-	 * tree, like retreiving the physical memory map or
-	 * calculating/retreiving the hash table size
+	 * Do early initialization using the flattened device
+	 * tree, such as retrieving the physical memory map or
+	 * calculating/retrieving the hash table size.
 	 */
 	early_init_devtree(__va(dt_ptr));
 
Index: linux-2.6.22-git2/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/kernel/prom.c	2007-09-05 14:23:06.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/kernel/prom.c	2007-09-05 14:24:49.000000000 -0500
@@ -433,9 +433,11 @@ static int __init early_parse_mem(char *
 }
 early_param("mem", early_parse_mem);
 
-/*
- * The device tree may be allocated below our memory limit, or inside the
- * crash kernel region for kdump. If so, move it out now.
+/**
+ * move_device_tree - move tree to an unused area, if needed.
+ *
+ * The device tree may be allocated beyond our memory limit, or inside the
+ * crash kernel region for kdump. If so, move it out of the way.
  */
 static void move_device_tree(void)
 {
