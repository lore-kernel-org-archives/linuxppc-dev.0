Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0FC78DDEED
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 03:46:18 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l86HkFOE027501
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 13:46:15 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l86HkF1Z452948
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 11:46:15 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l86HkFUt023682
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Sep 2007 11:46:15 -0600
Date: Thu, 6 Sep 2007 12:46:15 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/3] powerpc: prom whitespace cleanup
Message-ID: <20070906174615.GB21800@austin.ibm.com>
References: <20070906174416.GW4584@austin.ibm.com>
	<20070906174521.GA21800@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070906174521.GA21800@austin.ibm.com>
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


Whitespace cleanup: badly indented lines.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----

 arch/powerpc/kernel/prom.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/kernel/prom.c	2007-08-29 14:14:12.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/kernel/prom.c	2007-08-29 14:15:10.000000000 -0500
@@ -782,13 +782,13 @@ static int __init early_init_dt_scan_cho
 #endif
 
 #ifdef CONFIG_KEXEC
-       lprop = (u64*)of_get_flat_dt_prop(node, "linux,crashkernel-base", NULL);
-       if (lprop)
-               crashk_res.start = *lprop;
-
-       lprop = (u64*)of_get_flat_dt_prop(node, "linux,crashkernel-size", NULL);
-       if (lprop)
-               crashk_res.end = crashk_res.start + *lprop - 1;
+	lprop = (u64*)of_get_flat_dt_prop(node, "linux,crashkernel-base", NULL);
+	if (lprop)
+		crashk_res.start = *lprop;
+
+	lprop = (u64*)of_get_flat_dt_prop(node, "linux,crashkernel-size", NULL);
+	if (lprop)
+		crashk_res.end = crashk_res.start + *lprop - 1;
 #endif
 
 	early_init_dt_check_for_initrd(node);
