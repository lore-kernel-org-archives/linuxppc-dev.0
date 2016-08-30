Return-Path: <kim.phillips@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sNyjQ1LpnzDrht
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 05:08:42 +1000 (AEST)
Date: Tue, 30 Aug 2016 14:08:39 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Johannes
 Weiner <hannes@cmpxchg.org>, Arnd Bergmann <arnd@arndb.de>, Tejun Heo
 <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Michael Ellerman <mpe@ellerman.id.au>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland
 <mark.rutland@arm.com>
Subject: [PATCH 2/2] arm64: don't select PERF_USE_VMALLOC by default
Message-Id: <20160830140839.75e0689719bf884c9e38e5e4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Any arm64 based parts that have cache aliasing issues can set it
manually.  Apparently dragged in from ARM(32) defaults in commit
8c2c3df "arm64: Build infrastructure".

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f..2e6874f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -105,7 +105,6 @@ config ARM64
 	select OF_NUMA if NUMA && OF
 	select OF_RESERVED_MEM
 	select PCI_ECAM if ACPI
-	select PERF_USE_VMALLOC
 	select POWER_RESET
 	select POWER_SUPPLY
 	select SPARSE_IRQ
-- 
2.9.3
