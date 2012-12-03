Return-Path: <m.szyprowski@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13]) by ozlabs.org (Postfix) with ESMTP id 28D012C007D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2012 19:52:01 +1100 (EST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MEG009FK62YOC30@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 03 Dec 2012 08:54:34 +0000 (GMT)
Received: from [127.0.0.1] ([106.116.147.30])
 by eusync2.samsung.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPA id <0MEG00IUH5YHQ700@eusync2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 03 Dec 2012 08:51:56 +0000 (GMT)
Message-id: <50BC6829.4060205@samsung.com>
Date: Mon, 03 Dec 2012 09:51:53 +0100
From: Marek Szyprowski <m.szyprowski@samsung.com>
MIME-version: 1.0
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/9] dma_debug: add debug_dma_mapping_error support to
 architectures that support DMA_DEBUG_API
References: <1353706142.5270.93.camel@lorien2> <50B34B0F.3080204@samsung.com>
 <20121202140644.GP30633@8bytes.org>
In-reply-to: <20121202140644.GP30633@8bytes.org>
Content-type: text/plain; charset=UTF-8; format=flowed
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, a-jacquiot@ti.com,
 catalin.marinas@arm.com, Ming Lei <ming.lei@canonical.com>,
 shuahkhan@gmail.com, sparclinux@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 linux-sh@vger.kernel.org, msalter@redhat.com, shuah.khan@hp.com,
 fenghua.yu@intel.com, microblaze-uclinux@itee.uq.edu.au,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org, lethal@linux-sh.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12/2/2012 3:06 PM, Joerg Roedel wrote:
> Hi Marek,
>   
> On Mon, Nov 26, 2012 at 11:57:19AM +0100, Marek Szyprowski wrote:
>
> > I've took all the patches to the next-dma-debug branch in my tree, I sorry
> > that You have to wait so long for it. My branch is based on Joerg's
> > dma-debug branch and I've included it for testing in linux-next branch.
>
> The patches are now two times in next. One version from my tree and one
> from yours. Please remove the version from your tree, the patches should
> go upstream via my dma-debug branch.

Ok, I've removed them from my dma-mapping-next tree. Please add/cherry-pick
the missing patch for ARM architecture, which I've accidentally already
pushed to mainline some time ago and then reverted. See commit
871ae57adc5ed092 (and 697575896670ba).

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
