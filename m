Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A8B552C008A
 for <linuxppc-dev@ozlabs.org>; Sun,  7 Apr 2013 03:07:13 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 6 Apr 2013 11:07:11 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 927351FF003C
 for <linuxppc-dev@ozlabs.org>; Sat,  6 Apr 2013 11:02:08 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r36H77EZ130452
 for <linuxppc-dev@ozlabs.org>; Sat, 6 Apr 2013 11:07:07 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r36H77dt011083
 for <linuxppc-dev@ozlabs.org>; Sat, 6 Apr 2013 11:07:07 -0600
Date: Sat, 6 Apr 2013 10:06:24 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] perf: Power7 Update testing ABI to list CPI-stack events
Message-ID: <20130406170623.GA900@us.ibm.com>
References: <20130406164803.GA408@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130406164803.GA408@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 03a785f9d19249d2e524f31d8ead539f15d28a9f Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Sat, 6 Apr 2013 09:52:05 -0700
Subject: [PATCH] perf: Power7 Update testing ABI to list CPI-stack events

Following patch added several Power7 events into /sys/devices/cpu/events.
Document those events in the testing ABI.

	https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-April/105167.html

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 .../testing/sysfs-bus-event_source-devices-events  |   32 ++++++++++++++++---
 1 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 0adeb52..8b25ffb 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -27,14 +27,36 @@ Description:	Generic performance monitoring events
 		"basename".
 
 
-What: 		/sys/devices/cpu/events/PM_LD_MISS_L1
-		/sys/devices/cpu/events/PM_LD_REF_L1
-		/sys/devices/cpu/events/PM_CYC
+What: 		/sys/devices/cpu/events/PM_1PLUS_PPC_CMPL
 		/sys/devices/cpu/events/PM_BRU_FIN
-		/sys/devices/cpu/events/PM_GCT_NOSLOT_CYC
 		/sys/devices/cpu/events/PM_BRU_MPRED
-		/sys/devices/cpu/events/PM_INST_CMPL
 		/sys/devices/cpu/events/PM_CMPLU_STALL
+		/sys/devices/cpu/events/PM_CMPLU_STALL_BRU
+		/sys/devices/cpu/events/PM_CMPLU_STALL_DCACHE_MISS
+		/sys/devices/cpu/events/PM_CMPLU_STALL_DFU
+		/sys/devices/cpu/events/PM_CMPLU_STALL_DIV
+		/sys/devices/cpu/events/PM_CMPLU_STALL_ERAT_MISS
+		/sys/devices/cpu/events/PM_CMPLU_STALL_FXU
+		/sys/devices/cpu/events/PM_CMPLU_STALL_IFU
+		/sys/devices/cpu/events/PM_CMPLU_STALL_LSU
+		/sys/devices/cpu/events/PM_CMPLU_STALL_REJECT
+		/sys/devices/cpu/events/PM_CMPLU_STALL_SCALAR
+		/sys/devices/cpu/events/PM_CMPLU_STALL_SCALAR_LONG
+		/sys/devices/cpu/events/PM_CMPLU_STALL_STORE
+		/sys/devices/cpu/events/PM_CMPLU_STALL_THRD
+		/sys/devices/cpu/events/PM_CMPLU_STALL_VECTOR
+		/sys/devices/cpu/events/PM_CMPLU_STALL_VECTOR_LONG
+		/sys/devices/cpu/events/PM_CYC
+		/sys/devices/cpu/events/PM_GCT_NOSLOT_BR_MPRED
+		/sys/devices/cpu/events/PM_GCT_NOSLOT_BR_MPRED_IC_MISS
+		/sys/devices/cpu/events/PM_GCT_NOSLOT_CYC
+		/sys/devices/cpu/events/PM_GCT_NOSLOT_IC_MISS
+		/sys/devices/cpu/events/PM_GRP_CMPL
+		/sys/devices/cpu/events/PM_INST_CMPL
+		/sys/devices/cpu/events/PM_LD_MISS_L1
+		/sys/devices/cpu/events/PM_LD_REF_L1
+		/sys/devices/cpu/events/PM_RUN_CYC
+		/sys/devices/cpu/events/PM_RUN_INST_CMPL
 
 Date:		2013/01/08
 
-- 
1.7.1
