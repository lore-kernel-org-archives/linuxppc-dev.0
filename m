Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLtpP2cDfzDqfh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 00:07:09 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id p87so19641057pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 06:07:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 0/3] powerpc/64s/radix: misc minor TLB flush fixes
Date: Tue, 24 Oct 2017 23:06:51 +1000
Message-Id: <20171024130654.1223-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

*** BLURB HERE ***

Nicholas Piggin (3):
  powerpc/64s/radix: fix preempt imbalance in TLB flush
  powerpc/64s/radix: tlbie improve preempt handling
  powerpc/64s/radix: Fix process table entry cache invalidation

 arch/powerpc/include/asm/mmu_context.h |  4 +++
 arch/powerpc/mm/mmu_context_book3s64.c | 25 ++++++++++++----
 arch/powerpc/mm/tlb-radix.c            | 53 +++++++++++++++++-----------------
 3 files changed, 51 insertions(+), 31 deletions(-)

-- 
2.13.3
