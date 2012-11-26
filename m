Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org [85.214.48.195])
 by ozlabs.org (Postfix) with ESMTP id E24052C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 22:42:00 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 841A512B07B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 12:22:21 +0100 (CET)
Date: Mon, 26 Nov 2012 12:22:17 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Shuah Khan <shuah.khan@hp.com>
Subject: Re: [PATCH 0/9] dma_debug: add debug_dma_mapping_error support to
 architectures that support DMA_DEBUG_API
Message-ID: <20121126112217.GG25742@8bytes.org>
References: <1353706142.5270.93.camel@lorien2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353706142.5270.93.camel@lorien2>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, a-jacquiot@ti.com,
 catalin.marinas@arm.com, Ming Lei <ming.lei@canonical.com>,
 shuahkhan@gmail.com, sparclinux@vger.kernel.org, m.szyprowski@samsung.com,
 linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, msalter@redhat.com,
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

Hi Shuah,

On Fri, Nov 23, 2012 at 02:29:02PM -0700, Shuah Khan wrote:
> x86 - done in the first patch that added the feature.
> 
> ARM64: dma_debug: add debug_dma_mapping_error support
> c6x: dma_debug: add debug_dma_mapping_error support
> ia64: dma_debug: add debug_dma_mapping_error support
> microblaze: dma-mapping: support debug_dma_mapping_error
> mips: dma_debug: add debug_dma_mapping_error support
> powerpc: dma_debug: add debug_dma_mapping_error support
> sh: dma_debug: add debug_dma_mapping_error support
> sparc: dma_debug: add debug_dma_mapping_error support
> tile: dma_debug: add debug_dma_mapping_error support

Have you compile-tested the invididual archs you are changing here?


	Joerg
