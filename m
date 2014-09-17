Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 942A31A013E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 04:34:23 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 17 Sep 2014 14:34:21 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9DE7E38C8039
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 14:34:18 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8HIYAXf6226216
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 18:34:18 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8HIXi3w027564
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 14:33:45 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, ak@linux.intel.com,
 Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org, eranian@google.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/4] powerpc/perf: Miscellaneous fixes
Date: Wed, 17 Sep 2014 11:33:03 -0700
Message-Id: <1410978787-7375-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org,
 Michael Ellerman <michaele@au1.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Miscellaenous fixes for perf and 24x7 counters in powerpc.

Patches 1,3,4 were submitted earlier as a part of the parametrized
events for 24x7 counters. But they are not directly related to the
parametrized events.

Patch 2 simplifies and fixes a bug in catalog_read() which causes the
catalog file to not read first page.

Cody P Schafer (3):
  powerpc/perf/hv-24x7: use kmem_cache instead of aligned stack
    allocations
  perf Documentation: sysfs events/ interfaces
  perf Documentation: remove duplicated docs for powerpc cpu specific
    events

Sukadev Bhattiprolu (1):
  Simplify catalog_read()

 .../testing/sysfs-bus-event_source-devices-events  |  611 ++------------------
 arch/powerpc/perf/hv-24x7.c                        |  144 ++---
 2 files changed, 96 insertions(+), 659 deletions(-)

-- 
1.7.9.5
