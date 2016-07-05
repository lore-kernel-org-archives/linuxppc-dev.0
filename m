Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkDB32VhqzDsrN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 16:14:35 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u656EVkF077520
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 02:14:32 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23xa4cu5kr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jul 2016 02:14:32 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 5 Jul 2016 16:14:25 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8F2762CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 16:14:23 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u656ENvV11665688
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 16:14:23 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u656EMrP025564
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 16:14:23 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, oss@buserror.net, geoff@infradead.org
Subject: [PATCH 2/3] powerpc: fix typo in comment reference to
 CONFIG_TRACE_IRQFLAGS
Date: Tue,  5 Jul 2016 16:12:34 +1000
In-Reply-To: <1467699155-19108-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1467699155-19108-1-git-send-email-andrew.donnellan@au1.ibm.com>
Message-Id: <1467699155-19108-2-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 3cb46a3..58217ae 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -250,7 +250,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 		if (WARN_ON(mfmsr() & MSR_EE))
 			__hard_irq_disable();
 	}
-#endif /* CONFIG_TRACE_IRQFLAG */
+#endif /* CONFIG_TRACE_IRQFLAGS */
 
 	set_soft_enabled(0);
 
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
