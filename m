Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7rNF6dYKzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 20:38:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: gwshan@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 Michael Neuling <mikey@neuling.org>
Subject: [PATCH stable 4.6 0/4] powerpc patches for 4.6 stable
Date: Tue,  9 Aug 2016 20:38:04 +1000
Message-Id: <1470739088-17850-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the set of patches I have so far tagged for 4.6 stable.

Please let me know if any of these *shouldn't* go to stable.

Gavin Shan (2):
  powerpc/eeh: Fix invalid cached PE primary bus
  powerpc/eeh: Fix wrong argument passed to eeh_rmv_device()

Michael Neuling (1):
  powerpc/tm: Avoid SLB faults in treclaim/trecheckpoint when RI=0

Naveen N. Rao (1):
  powerpc/bpf/jit: Disable classic BPF JIT on ppc64le

 arch/powerpc/Kconfig             |  2 +-
 arch/powerpc/kernel/eeh_driver.c |  9 +++---
 arch/powerpc/kernel/tm.S         | 61 +++++++++++++++++++++++++++++-----------
 3 files changed, 50 insertions(+), 22 deletions(-)

-- 
2.7.4
