Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E209E1A0671
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 02:19:25 +1100 (AEDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3] powerpc: Use PFN_PHYS() to avoid truncating the
 physical address
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1427291352-31256-1-git-send-email-Emilian.Medve@Freescale.com>
Date: Thu, 26 Mar 2015 10:18:56 -0500
Message-Id: <FB8A0580-9A76-4F83-BDE7-2EECC0063C1C@kernel.crashing.org>
References: <1427291352-31256-1-git-send-email-Emilian.Medve@Freescale.com>
To: Emil Medve <Emilian.Medve@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Why no commit message with what issue this change was trying to fix?

- k

On Mar 25, 2015, at 8:49 AM, Emil Medve <Emilian.Medve@freescale.com> wrote:

> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
> 
> v3: Rebased and updated due to upstream changes since v2
> 
> v2: Rebased and updated due to upstream changes since v1
> 
> arch/powerpc/include/asm/io.h          | 2 +-
> arch/powerpc/include/asm/page.h        | 2 +-
> arch/powerpc/include/asm/pgalloc-32.h  | 2 +-
> arch/powerpc/include/asm/rtas.h        | 3 ++-
> arch/powerpc/kernel/crash_dump.c       | 2 +-
> arch/powerpc/kernel/eeh.c              | 4 +---
> arch/powerpc/kernel/io-workarounds.c   | 2 +-
> arch/powerpc/kernel/pci-common.c       | 2 +-
> arch/powerpc/kernel/vdso.c             | 6 +++---
> arch/powerpc/kvm/book3s_64_mmu_host.c  | 2 +-
> arch/powerpc/kvm/book3s_64_mmu_hv.c    | 2 +-
> arch/powerpc/kvm/book3s_hv_rm_mmu.c    | 4 ++--
> arch/powerpc/kvm/e500_mmu_host.c       | 5 ++---
> arch/powerpc/mm/hugepage-hash64.c      | 2 +-
> arch/powerpc/mm/hugetlbpage-book3e.c   | 2 +-
> arch/powerpc/mm/hugetlbpage-hash64.c   | 2 +-
> arch/powerpc/mm/mem.c                  | 9 ++++-----
> arch/powerpc/mm/numa.c                 | 5 ++---
> arch/powerpc/platforms/powernv/opal.c  | 2 +-
> arch/powerpc/platforms/pseries/iommu.c | 8 ++++----
> 20 files changed, 32 insertions(+), 36 deletions(-)
