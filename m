Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e39.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D74C0B7120
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 16:01:01 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0L4mgWJ030207
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 21:48:42 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p0L50rVC094530
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 22:00:53 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0L50qp7017631
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jan 2011 22:00:53 -0700
Date: Thu, 20 Jan 2011 22:00:51 -0700
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Message-Id: <20110121050050.5062.98751.sendpatchset@oc7304238415.ibm.com>
In-Reply-To: <20110121050010.5062.3390.sendpatchset@oc7304238415.ibm.com>
References: <20110121050010.5062.3390.sendpatchset@oc7304238415.ibm.com>
Subject: [PATCH 1/4] powerpc/pseries: Fix typo in VPHN comments
Cc: markn@au1.ibm.com, tbreeds@au1.ibm.com, lkessler@us.ibm.com,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>, mjwolf@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>

Correct a spelling error in VPHN comments in numa.c.

Signed-off-by: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 8f8845e..5259dde 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1263,7 +1263,7 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
-/* Vrtual Processor Home Node (VPHN) support */
+/* Virtual Processor Home Node (VPHN) support */
 #ifdef CONFIG_PPC_SPLPAR
 #define VPHN_NR_CHANGE_CTRS (8)
 static u8 vphn_cpu_change_counts[NR_CPUS][VPHN_NR_CHANGE_CTRS];
-- 
1.7.3.4
