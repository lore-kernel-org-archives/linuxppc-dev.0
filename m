Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0D481A0B60
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 23:25:07 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 29 Feb 2016 05:25:04 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E410819D8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 05:12:48 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1TCOqFc35913782
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 05:24:52 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1TCOpDn023452
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 05:24:52 -0700
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mahesh@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 0/3] powerpc/powernv: Cpuidle related cleanup
Date: Mon, 29 Feb 2016 17:52:57 +0530
Message-Id: <1456748580-10519-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches are purely code movement and cleanup.
There is no functionality change.

Note, there are multiple style error reported for patch 1 and 2.
I think this is because checkpatch script mistakes the patches
as C code because of the presence of semi-colon in each line. I
for now have largely ignored these errors.

Shreyas B. Prabhu (3):
  powerpc/powernv: Move CHECK_HMI_INTERRUPT to exception-64s header
  powerpc/powernv: Encapsulate idle preparation steps in a macro
  powerpc/powernv: make hypervisor state restore a function

 arch/powerpc/include/asm/cpuidle.h       |  68 ++++++++++++++
 arch/powerpc/include/asm/exception-64s.h |  19 ++++
 arch/powerpc/kernel/exceptions-64s.S     |  29 +-----
 arch/powerpc/kernel/idle_power7.S        | 148 ++++++++-----------------------
 4 files changed, 129 insertions(+), 135 deletions(-)

-- 
1.9.3
