Return-Path: <cody@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C853F2C00D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 11:45:28 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 19:45:26 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D3E836E803C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 19:45:18 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s260jO6u8192340
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Mar 2014 00:45:24 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s260jNte015657
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 19:45:24 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: linux-doc@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH 2/2] perf Documentation: remove duplicated docs for powerpc
 cpu specific events
Date: Wed,  5 Mar 2014 16:44:15 -0800
Message-Id: <1394066658-16766-3-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1394066658-16766-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1394066658-16766-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: rob@landley.net, Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Listing specific events doesn't actually help us at all here because:
 - these events actually vary between different ppc processors, they
   aren't garunteed to be present.
 - the documentation of the file contents is now duplicated by the
   docs for arbitrary event file contents.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 .../testing/sysfs-bus-event_source-devices-events  | 57 ----------------------
 1 file changed, 57 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 5393e1ed6..50c30a6 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -26,63 +26,6 @@ Description:	Generic performance monitoring events
 		"raw code" for the perf event identified by the file's
 		"basename".
 
-
-What: 		/sys/devices/cpu/events/PM_1PLUS_PPC_CMPL
-		/sys/devices/cpu/events/PM_BRU_FIN
-		/sys/devices/cpu/events/PM_BR_MPRED
-		/sys/devices/cpu/events/PM_CMPLU_STALL
-		/sys/devices/cpu/events/PM_CMPLU_STALL_BRU
-		/sys/devices/cpu/events/PM_CMPLU_STALL_DCACHE_MISS
-		/sys/devices/cpu/events/PM_CMPLU_STALL_DFU
-		/sys/devices/cpu/events/PM_CMPLU_STALL_DIV
-		/sys/devices/cpu/events/PM_CMPLU_STALL_ERAT_MISS
-		/sys/devices/cpu/events/PM_CMPLU_STALL_FXU
-		/sys/devices/cpu/events/PM_CMPLU_STALL_IFU
-		/sys/devices/cpu/events/PM_CMPLU_STALL_LSU
-		/sys/devices/cpu/events/PM_CMPLU_STALL_REJECT
-		/sys/devices/cpu/events/PM_CMPLU_STALL_SCALAR
-		/sys/devices/cpu/events/PM_CMPLU_STALL_SCALAR_LONG
-		/sys/devices/cpu/events/PM_CMPLU_STALL_STORE
-		/sys/devices/cpu/events/PM_CMPLU_STALL_THRD
-		/sys/devices/cpu/events/PM_CMPLU_STALL_VECTOR
-		/sys/devices/cpu/events/PM_CMPLU_STALL_VECTOR_LONG
-		/sys/devices/cpu/events/PM_CYC
-		/sys/devices/cpu/events/PM_GCT_NOSLOT_BR_MPRED
-		/sys/devices/cpu/events/PM_GCT_NOSLOT_BR_MPRED_IC_MISS
-		/sys/devices/cpu/events/PM_GCT_NOSLOT_CYC
-		/sys/devices/cpu/events/PM_GCT_NOSLOT_IC_MISS
-		/sys/devices/cpu/events/PM_GRP_CMPL
-		/sys/devices/cpu/events/PM_INST_CMPL
-		/sys/devices/cpu/events/PM_LD_MISS_L1
-		/sys/devices/cpu/events/PM_LD_REF_L1
-		/sys/devices/cpu/events/PM_RUN_CYC
-		/sys/devices/cpu/events/PM_RUN_INST_CMPL
-
-Date:		2013/01/08
-
-Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
-		Linux Powerpc mailing list <linuxppc-dev@ozlabs.org>
-
-Description:	POWER-systems specific performance monitoring events
-
-		A collection of performance monitoring events that may be
-		supported by the POWER CPU. These events can be monitored
-		using the 'perf(1)' tool.
-
-		These events may not be supported by other CPUs.
-
-		The contents of each file would look like:
-
-			event=0xNNNN
-
-		where 'N' is a hex digit and the number '0xNNNN' shows the
-		"raw code" for the perf event identified by the file's
-		"basename".
-
-		Further, multiple terms like 'event=0xNNNN' can be specified
-		and separated with comma. All available terms are defined in
-		the /sys/bus/event_source/devices/<dev>/format file.
-
 What: /sys/bus/event_source/devices/<pmu>/events/<event>
 Date: 2014/02/24
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
-- 
1.9.0
