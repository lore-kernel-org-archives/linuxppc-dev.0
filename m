Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org
 [IPv6:2a01:238:4242:f000:64f:6c43:3523:e535])
 by ozlabs.org (Postfix) with ESMTP id 3ED5D2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 22:26:55 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 813F812B0C6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 12:21:02 +0100 (CET)
Date: Mon, 26 Nov 2012 12:20:58 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 0/9] dma_debug: add debug_dma_mapping_error support to
 architectures that support DMA_DEBUG_API
Message-ID: <20121126112058.GF25742@8bytes.org>
References: <1353706142.5270.93.camel@lorien2> <50B34B0F.3080204@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50B34B0F.3080204@samsung.com>
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

On Mon, Nov 26, 2012 at 11:57:19AM +0100, Marek Szyprowski wrote:
> I've took all the patches to the next-dma-debug branch in my tree, I sorry
> that You have to wait so long for it. My branch is based on Joerg's
> dma-debug branch and I've included it for testing in linux-next branch.
> 
> Joerg: would You mind if I handle pushing the whole branch to v3.8
> via my kernel tree? Those changes should be kept close together to
> avoid build breaks for bisecting.

I'll apply the patches to my tree soon enough. But before that I'll wait
a little bit longer to give the arch maintainers the chance to add the
missing Acked-bys.


	Joerg
