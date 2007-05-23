Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA536DDF7B
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 03:23:42 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4NHNdB5021851
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:23:39 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4NHNdEY367428
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:23:39 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4NHNdA5007093
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:23:39 -0400
Date: Wed, 23 May 2007 12:23:38 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/4] powerpc: remove dead EEH code.
Message-ID: <20070523172338.GC32380@austin.ibm.com>
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


Remove some dead code.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.22-rc1.orig/arch/powerpc/platforms/pseries/eeh.c	2007-05-23 11:57:28.000000000 -0500
+++ linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh.c	2007-05-23 11:57:34.000000000 -0500
@@ -117,7 +117,6 @@ static unsigned long no_cfg_addr;
 static unsigned long ignored_check;
 static unsigned long total_mmio_ffs;
 static unsigned long false_positives;
-static unsigned long ignored_failures;
 static unsigned long slot_resets;
 
 #define IS_BRIDGE(class_code) (((class_code)<<16) == PCI_BASE_CLASS_BRIDGE)
@@ -1221,11 +1220,10 @@ static int proc_eeh_show(struct seq_file
 				"check not wanted=%ld\n"
 				"eeh_total_mmio_ffs=%ld\n"
 				"eeh_false_positives=%ld\n"
-				"eeh_ignored_failures=%ld\n"
 				"eeh_slot_resets=%ld\n",
 				no_device, no_dn, no_cfg_addr, 
 				ignored_check, total_mmio_ffs, 
-				false_positives, ignored_failures, 
+				false_positives,
 				slot_resets);
 	}
 
