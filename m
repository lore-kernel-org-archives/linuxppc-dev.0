Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rB96K5bVLzDqBM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 00:19:05 +1000 (AEST)
Received: from localhost
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 20 May 2016 15:19:01 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 872C3219005E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 15:18:34 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4KEIxpB22938002
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 14:18:59 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4KEIwN0010926
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 08:18:59 -0600
Subject: [PATCH] powerpc/pseries: fix trivial typo in function name
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, trivial@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 20 May 2016 16:18:57 +0200
Message-ID: <146375393699.3856.7906809763866981800.stgit@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtasd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 5a2c049c1c61..b6e7a935d8b0 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -483,7 +483,7 @@ static void rtas_event_scan(struct work_struct *w)
 }
 
 #ifdef CONFIG_PPC64
-static void retreive_nvram_error_log(void)
+static void retrieve_nvram_error_log(void)
 {
 	unsigned int err_type ;
 	int rc ;
@@ -501,7 +501,7 @@ static void retreive_nvram_error_log(void)
 	}
 }
 #else /* CONFIG_PPC64 */
-static void retreive_nvram_error_log(void)
+static void retrieve_nvram_error_log(void)
 {
 }
 #endif /* CONFIG_PPC64 */
@@ -513,7 +513,7 @@ static void start_event_scan(void)
 		 (30000 / rtas_event_scan_rate));
 
 	/* Retrieve errors from nvram if any */
-	retreive_nvram_error_log();
+	retrieve_nvram_error_log();
 
 	schedule_delayed_work_on(cpumask_first(cpu_online_mask),
 				 &event_scan_work, event_scan_delay);
