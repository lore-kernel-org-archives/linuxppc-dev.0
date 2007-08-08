Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49CCCDDEE0
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 06:04:52 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78J05RJ013202
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 15:00:05 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78K4nP0551256
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 16:04:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78K4nRn024502
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 16:04:49 -0400
Date: Wed, 8 Aug 2007 15:04:48 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/6] powerpc: remove nvram forward declarations
Message-ID: <20070808200448.GD20134@austin.ibm.com>
References: <20070808195916.GA20055@austin.ibm.com>
	<20070808200115.GA20134@austin.ibm.com>
	<20070808200210.GB20134@austin.ibm.com>
	<20070808200337.GC20134@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070808200337.GC20134@austin.ibm.com>
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


Forward declarations serve no purpose in this file.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----

 arch/powerpc/kernel/nvram_64.c |    5 -----
 1 file changed, 5 deletions(-)

Index: linux-2.6.22-git2/arch/powerpc/kernel/nvram_64.c
===================================================================
--- linux-2.6.22-git2.orig/arch/powerpc/kernel/nvram_64.c	2007-08-08 12:19:17.000000000 -0500
+++ linux-2.6.22-git2/arch/powerpc/kernel/nvram_64.c	2007-08-08 12:21:05.000000000 -0500
@@ -34,11 +34,6 @@
 
 #undef DEBUG_NVRAM
 
-static int nvram_scan_partitions(void);
-static int nvram_setup_partition(void);
-static int nvram_create_os_partition(void);
-static int nvram_remove_os_partition(void);
-
 static struct nvram_partition * nvram_part;
 static long nvram_error_log_index = -1;
 static long nvram_error_log_size = 0;
