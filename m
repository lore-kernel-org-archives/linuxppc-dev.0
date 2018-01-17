Return-Path: <srs0=4i2n=em=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLqmf6zw6zF0bc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 12:50:42 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zLqmf4w8Sz8x0M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 12:50:42 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zLqmf0DyPz9sP1
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 12:50:41 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0H1moDV006562
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 20:50:40 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fhvt68r7e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 20:50:39 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 16 Jan 2018 20:50:38 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] powerpc: export set_thread_uses_vas()
Date: Tue, 16 Jan 2018 17:50:32 -0800
In-Reply-To: <1516153832-9282-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1516153832-9282-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1516153832-9282-2-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index f20c1ad..d22055b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1475,6 +1475,7 @@ int set_thread_uses_vas(void)
 #endif /* CONFIG_PPC_BOOK3S_64 */
 	return 0;
 }
+EXPORT_SYMBOL_GPL(set_thread_uses_vas);
 
 #ifdef CONFIG_PPC64
 static DEFINE_SPINLOCK(vas_thread_id_lock);
-- 
2.7.4
