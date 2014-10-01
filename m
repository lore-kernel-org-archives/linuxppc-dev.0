Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ADE11A178A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 16:03:58 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 02:03:56 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E706C6E8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 01:52:39 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9163sho9765370
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 06:03:54 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9163r0K007669
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 02:03:54 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, ak@linux.intel.com,
 Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org, eranian@google.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/5] powerpc: Update contact info in Documentation files
Date: Tue, 30 Sep 2014 23:03:21 -0700
Message-Id: <1412143402-26061-6-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1412143402-26061-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1412143402-26061-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 dev@codyps.com, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cody's email address has changed. Update the contact information for
the 24x7 and GPCI counters to the PowerPC developers mailing list.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 .../ABI/testing/sysfs-bus-event_source-devices-hv_24x7       |  6 +++---
 .../ABI/testing/sysfs-bus-event_source-devices-hv_gpci       | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
index e78ee79..32f3f5f 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
@@ -1,6 +1,6 @@
 What:		/sys/bus/event_source/devices/hv_24x7/interface/catalog
 Date:		February 2014
-Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
 Description:
 		Provides access to the binary "24x7 catalog" provided by the
 		hypervisor on POWER7 and 8 systems. This catalog lists events
@@ -10,14 +10,14 @@ Description:
 
 What:		/sys/bus/event_source/devices/hv_24x7/interface/catalog_length
 Date:		February 2014
-Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
 Description:
 		A number equal to the length in bytes of the catalog. This is
 		also extractable from the provided binary "catalog" sysfs entry.
 
 What:		/sys/bus/event_source/devices/hv_24x7/interface/catalog_version
 Date:		February 2014
-Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
 Description:
 		Exposes the "version" field of the 24x7 catalog. This is also
 		extractable from the provided binary "catalog" sysfs entry.
diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
index 3fa58c2..3ca4e55 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
@@ -1,6 +1,6 @@
 What:		/sys/bus/event_source/devices/hv_gpci/interface/collect_privileged
 Date:		February 2014
-Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
 Description:
 		'0' if the hypervisor is configured to forbid access to event
 		counters being accumulated by other guests and to physical
@@ -9,35 +9,35 @@ Description:
 
 What:		/sys/bus/event_source/devices/hv_gpci/interface/ga
 Date:		February 2014
-Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
 Description:
 		0 or 1. Indicates whether we have access to "GA" events (listed
 		in arch/powerpc/perf/hv-gpci.h).
 
 What:		/sys/bus/event_source/devices/hv_gpci/interface/expanded
 Date:		February 2014
-Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
 Description:
 		0 or 1. Indicates whether we have access to "EXPANDED" events (listed
 		in arch/powerpc/perf/hv-gpci.h).
 
 What:		/sys/bus/event_source/devices/hv_gpci/interface/lab
 Date:		February 2014
-Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
 Description:
 		0 or 1. Indicates whether we have access to "LAB" events (listed
 		in arch/powerpc/perf/hv-gpci.h).
 
 What:		/sys/bus/event_source/devices/hv_gpci/interface/version
 Date:		February 2014
-Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
 Description:
 		A number indicating the version of the gpci interface that the
 		hypervisor reports supporting.
 
 What:		/sys/bus/event_source/devices/hv_gpci/interface/kernel_version
 Date:		February 2014
-Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
 Description:
 		A number indicating the latest version of the gpci interface
 		that the kernel is aware of.
-- 
1.8.3.1
