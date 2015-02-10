Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 517201A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:27:59 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 19:27:56 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 02EBF1FF002D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 19:19:05 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2QJYB32178250
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:26:27 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RKHO019512
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:27:20 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 01/18] powerpc/powernv: sync OPAL API tokens with skiboot
Date: Tue, 10 Feb 2015 13:26:43 +1100
Message-Id: <1423535220-6322-2-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch just matches whitespace and comments between
the opal.h from firmware and that in linux.

No addition/removal.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index eb95b67..4694183 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -40,7 +40,7 @@ struct opal_sg_list {
 /****** OPAL APIs ******/
 
 /* Return codes */
-#define OPAL_SUCCESS 		0
+#define OPAL_SUCCESS		0
 #define OPAL_PARAMETER		-1
 #define OPAL_BUSY		-2
 #define OPAL_PARTIAL		-3
@@ -109,7 +109,7 @@ struct opal_sg_list {
 #define OPAL_GET_MSI_64				40
 #define OPAL_START_CPU				41
 #define OPAL_QUERY_CPU_STATUS			42
-#define OPAL_WRITE_OPPANEL			43
+#define OPAL_WRITE_OPPANEL			43 /* unimplemented */
 #define OPAL_PCI_MAP_PE_DMA_WINDOW		44
 #define OPAL_PCI_MAP_PE_DMA_WINDOW_REAL		45
 #define OPAL_PCI_RESET				49
-- 
1.7.10.4
