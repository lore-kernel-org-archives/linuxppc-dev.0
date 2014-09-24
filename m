Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C30F51A18A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 05:28:07 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 24 Sep 2014 15:28:05 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4D95FC9002E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 15:16:47 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8OJS2Is9699824
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 19:28:02 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8OJRxcF001597
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 15:28:02 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, ak@linux.intel.com,
 Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org, eranian@google.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v4 10/10] powerpc/perf/hv-24x7: Document sysfs event
 description entries
Date: Wed, 24 Sep 2014 12:27:24 -0700
Message-Id: <1411586844-21381-11-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1411586844-21381-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1411586844-21381-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

From: Cody P Schafer <cody@linux.vnet.ibm.com>

CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
CC: Haren Myneni <hbabu@us.ibm.com>
CC: Cody P Schafer <dev@codyps.com>
Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 .../testing/sysfs-bus-event_source-devices-hv_24x7 | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
index e78ee79..5b501d7 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
@@ -21,3 +21,25 @@ Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
 Description:
 		Exposes the "version" field of the 24x7 catalog. This is also
 		extractable from the provided binary "catalog" sysfs entry.
+
+What:		/sys/bus/event_source/devices/hv_24x7/event_descs/<event-name>
+Date:		February 2014
+Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Description:
+		Provides the description of a particular event as provided by
+		the firmware. If firmware does not provide a description, no
+		file will be created.
+
+		Note that the event-name lacks the domain suffix appended for
+		events in the events/ dir.
+
+What:		/sys/bus/event_source/devices/hv_24x7/event_long_descs/<event-name>
+Date:		February 2014
+Contact:	Cody P Schafer <cody@linux.vnet.ibm.com>
+Description:
+		Provides the "long" description of a particular event as
+		provided by the firmware. If firmware does not provide a
+		description, no file will be created.
+
+		Note that the event-name lacks the domain suffix appended for
+		events in the events/ dir.
-- 
1.8.3.1
