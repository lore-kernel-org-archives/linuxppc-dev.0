Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B115C1A0165
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:27:27 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 21:27:25 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D23E338C8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 21:27:23 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2RNRU22937600
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 02:27:23 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RMZm015818
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 21:27:22 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 05/18] powerpc/powernv: synchronize opal.h whitespace with
 firmware
Date: Tue, 10 Feb 2015 13:26:47 +1100
Message-Id: <1423535220-6322-6-git-send-email-stewart@linux.vnet.ibm.com>
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

reduces the diff between linux and firmware header files significantly.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h |   51 +++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 0f9f06d..9ca5167 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -251,33 +251,32 @@ enum OpalShpcLinkState {
 enum OpalMmioWindowType {
 	OPAL_M32_WINDOW_TYPE = 1,
 	OPAL_M64_WINDOW_TYPE = 2,
-	OPAL_IO_WINDOW_TYPE = 3
+	OPAL_IO_WINDOW_TYPE  = 3
 };
-
 enum OpalShpcSlotState {
 	OPAL_SHPC_DEV_NOT_PRESENT = 0,
-	OPAL_SHPC_DEV_PRESENT = 1
+	OPAL_SHPC_DEV_PRESENT	  = 1
 };
 
 enum OpalExceptionHandler {
-	OPAL_MACHINE_CHECK_HANDLER = 1,
+	OPAL_MACHINE_CHECK_HANDLER	    = 1,
 	OPAL_HYPERVISOR_MAINTENANCE_HANDLER = 2,
-	OPAL_SOFTPATCH_HANDLER = 3
+	OPAL_SOFTPATCH_HANDLER		    = 3
 };
 
 enum OpalPendingState {
-	OPAL_EVENT_OPAL_INTERNAL	= 0x1,
-	OPAL_EVENT_NVRAM		= 0x2,
-	OPAL_EVENT_RTC			= 0x4,
-	OPAL_EVENT_CONSOLE_OUTPUT	= 0x8,
-	OPAL_EVENT_CONSOLE_INPUT	= 0x10,
-	OPAL_EVENT_ERROR_LOG_AVAIL	= 0x20,
-	OPAL_EVENT_ERROR_LOG		= 0x40,
-	OPAL_EVENT_EPOW			= 0x80,
-	OPAL_EVENT_LED_STATUS		= 0x100,
-	OPAL_EVENT_PCI_ERROR		= 0x200,
-	OPAL_EVENT_DUMP_AVAIL		= 0x400,
-	OPAL_EVENT_MSG_PENDING		= 0x800,
+	OPAL_EVENT_OPAL_INTERNAL   = 0x1,
+	OPAL_EVENT_NVRAM	   = 0x2,
+	OPAL_EVENT_RTC		   = 0x4,
+	OPAL_EVENT_CONSOLE_OUTPUT  = 0x8,
+	OPAL_EVENT_CONSOLE_INPUT   = 0x10,
+	OPAL_EVENT_ERROR_LOG_AVAIL = 0x20,
+	OPAL_EVENT_ERROR_LOG	   = 0x40,
+	OPAL_EVENT_EPOW		   = 0x80,
+	OPAL_EVENT_LED_STATUS	   = 0x100,
+	OPAL_EVENT_PCI_ERROR	   = 0x200,
+	OPAL_EVENT_DUMP_AVAIL	   = 0x400,
+	OPAL_EVENT_MSG_PENDING	   = 0x800,
 };
 
 enum OpalMessageType {
@@ -353,7 +352,7 @@ enum OpalPciReinitScope {
 
 enum OpalPciResetState {
 	OPAL_DEASSERT_RESET = 0,
-	OPAL_ASSERT_RESET = 1
+	OPAL_ASSERT_RESET   = 1
 };
 
 enum OpalPciMaskAction {
@@ -451,17 +450,17 @@ struct OpalMemoryErrorData {
 	union {
 		/* Memory Resilience corrected/uncorrected error info */
 		struct {
-			enum OpalMemErr_ResilErrType resil_err_type:8;
-			uint8_t		reserved_1[7];
-			__be64		physical_address_start;
-			__be64		physical_address_end;
+			enum OpalMemErr_ResilErrType	resil_err_type:8;
+			uint8_t				reserved_1[7];
+			__be64				physical_address_start;
+			__be64				physical_address_end;
 		} resilience;
 		/* Dynamic memory deallocation error info */
 		struct {
-			enum OpalMemErr_DynErrType dyn_err_type:8;
-			uint8_t		reserved_1[7];
-			__be64		physical_address_start;
-			__be64		physical_address_end;
+			enum OpalMemErr_DynErrType	dyn_err_type:8;
+			uint8_t				reserved_1[7];
+			__be64				physical_address_start;
+			__be64				physical_address_end;
 		} dyn_dealloc;
 	} u;
 };
-- 
1.7.10.4
