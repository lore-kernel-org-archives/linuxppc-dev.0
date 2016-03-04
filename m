Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E56E11A0B53
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 22:27:00 +1100 (AEDT)
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 11:26:57 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4D37C1B08019
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:27:19 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24BQtIG59703402
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:26:55 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24BQt9N007284
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 04:26:55 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 09/20] powerpc: New possible return value from hcall
Date: Fri,  4 Mar 2016 12:26:33 +0100
Message-Id: <1457090804-9719-10-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Lombard <clombard@linux.vnet.ibm.com>

The hcalls introduced for cxl use a possible new value:
H_STATE (invalid state).

Co-authored-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index e3b54dd..0bc9c28 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -94,6 +94,7 @@
 #define H_SG_LIST	-72
 #define H_OP_MODE	-73
 #define H_COP_HW	-74
+#define H_STATE		-75
 #define H_UNSUPPORTED_FLAG_START	-256
 #define H_UNSUPPORTED_FLAG_END		-511
 #define H_MULTI_THREADS_ACTIVE	-9005
-- 
1.9.1
