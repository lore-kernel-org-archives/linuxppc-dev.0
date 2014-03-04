Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com
 [IPv6:2607:f8b0:4001:c05::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 04F5B2C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 08:07:37 +1100 (EST)
Received: by mail-ig0-f171.google.com with SMTP id hl1so8996666igb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Mar 2014 13:07:32 -0800 (PST)
Subject: [PATCH 0/2] sched: Removed unused mc_capable() and smt_capable()
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 04 Mar 2014 14:07:31 -0700
Message-ID: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is just cleanup of a couple unused interfaces and (for sparc64) a
supporting variable.

---

Bjorn Helgaas (2):
      sched: Remove unused mc_capable() and smt_capable()
      sparc64: Remove unused sparc64_multi_core


 arch/arm/include/asm/topology.h      |    3 ---
 arch/ia64/include/asm/topology.h     |    1 -
 arch/mips/include/asm/topology.h     |    4 ----
 arch/powerpc/include/asm/topology.h  |    1 -
 arch/sparc/include/asm/smp_64.h      |    1 -
 arch/sparc/include/asm/topology_64.h |    2 --
 arch/sparc/kernel/mdesc.c            |    4 ----
 arch/sparc/kernel/prom_64.c          |    3 ---
 arch/sparc/kernel/smp_64.c           |    2 --
 arch/x86/include/asm/topology.h      |    6 ------
 10 files changed, 27 deletions(-)
