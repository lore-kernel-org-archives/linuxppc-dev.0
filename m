Return-Path: <m.szyprowski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14]) by ozlabs.org (Postfix) with ESMTP id 66F76B6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 19:42:37 +1100 (EST)
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Received: from euspt1 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0LXK00HGYQUWG430@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 10 Jan 2012 08:42:32 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LXK003JRQUW88@spt1.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 10 Jan 2012 08:42:32 +0000 (GMT)
Date: Tue, 10 Jan 2012 09:42:28 +0100
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 00/14] DMA-mapping framework redesign preparation
In-reply-to: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org
Message-id: <012501cccf73$c90246a0$5b06d3e0$%szyprowski@samsung.com>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
Cc: linux-arch@vger.kernel.org, 'Stephen Rothwell' <sfr@canb.auug.org.au>,
 linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
 'Arnd Bergmann' <arnd@arndb.de>, linux-sh@vger.kernel.org, x86@kernel.org,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 'Jonathan Corbet' <corbet@lwn.net>, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, 'Kyungmin Park' <kyungmin.park@samsung.com>,
 linux-mips@linux-mips.org, microblaze-uclinux@itee.uq.edu.au,
 sparclinux@vger.kernel.org, 'Thomas Gleixner' <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, 'Andrew Morton' <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, discuss@x86-64.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

To help everyone in testing and adapting our patches for his hardware 
platform I've rebased our patches onto the latest v3.2 Linux kernel and
prepared a few GIT branches in our public repository. These branches
contain our memory management related patches posted in the following
threads:

"[PATCHv18 0/11] Contiguous Memory Allocator":
http://www.spinics.net/lists/linux-mm/msg28125.html
later called CMAv18,

"[PATCH 00/14] DMA-mapping framework redesign preparation":
http://www.spinics.net/lists/linux-sh/msg09777.html
and
"[PATCH 0/8 v4] ARM: DMA-mapping framework redesign":
http://www.spinics.net/lists/arm-kernel/msg151147.html
with the following update:
http://www.spinics.net/lists/arm-kernel/msg154889.html
later called DMAv5.

These branches are available in our public GIT repository:

git://git.infradead.org/users/kmpark/linux-samsung
http://git.infradead.org/users/kmpark/linux-samsung/

The following branches are available:

1) 3.2-cma-v18
Vanilla Linux v3.2 with fixed CMA v18 patches (first patch replaced
with the one from v17 to fix SMP issues, see the respective thread).

2) 3.2-dma-v5
Vanilla Linux v3.2 + iommu/next (IOMMU maintainer's patches) branch
with DMA-preparation and DMA-mapping framework redesign patches.

3) 3.2-cma-v18-dma-v5
Previous two branches merged together (DMA-mapping on top of CMA)

4) 3.2-cma-v18-dma-v5-exynos
Previous branch rebased on top of iommu/next + kgene/for-next (Samsung
SoC platform maintainer's patches) with new Exynos4 IOMMU driver by 
KyongHo Cho and relevant glue code.

5) 3.2-dma-v5-exynos
Branch from point 2 rebased on top of iommu/next + kgene/for-next 
(Samsung SoC maintainer's patches) with new Exynos4 IOMMU driver by 
KyongHo Cho and relevant glue code.

I hope everyone will find a branch that suits his needs. :)

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
