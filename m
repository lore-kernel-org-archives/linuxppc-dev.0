Return-Path: <shuah.khan@hp.com>
Received: from g1t0026.austin.hp.com (g1t0026.austin.hp.com [15.216.28.33])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A49822C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2012 03:10:03 +1100 (EST)
Message-ID: <1353946190.2917.5.camel@lorien2>
Subject: Re: [PATCH 0/9] dma_debug: add debug_dma_mapping_error support to
 architectures that support DMA_DEBUG_API
From: Shuah Khan <shuah.khan@hp.com>
To: Joerg Roedel <joro@8bytes.org>
Date: Mon, 26 Nov 2012 09:09:50 -0700
In-Reply-To: <20121126112217.GG25742@8bytes.org>
References: <1353706142.5270.93.camel@lorien2>
 <20121126112217.GG25742@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, a-jacquiot@ti.com,
 catalin.marinas@arm.com, Ming Lei <ming.lei@canonical.com>,
 shuahkhan@gmail.com, sparclinux@vger.kernel.org, m.szyprowski@samsung.com,
 linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, msalter@redhat.com,
 fenghua.yu@intel.com, microblaze-uclinux@itee.uq.edu.au,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org, lethal@linux-sh.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Reply-To: shuah.khan@hp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-11-26 at 12:22 +0100, Joerg Roedel wrote:
> Hi Shuah,
> 
> On Fri, Nov 23, 2012 at 02:29:02PM -0700, Shuah Khan wrote:
> > x86 - done in the first patch that added the feature.
> > 
> > ARM64: dma_debug: add debug_dma_mapping_error support
> > c6x: dma_debug: add debug_dma_mapping_error support
> > ia64: dma_debug: add debug_dma_mapping_error support
> > microblaze: dma-mapping: support debug_dma_mapping_error
> > mips: dma_debug: add debug_dma_mapping_error support
> > powerpc: dma_debug: add debug_dma_mapping_error support
> > sh: dma_debug: add debug_dma_mapping_error support
> > sparc: dma_debug: add debug_dma_mapping_error support
> > tile: dma_debug: add debug_dma_mapping_error support
> 
> Have you compile-tested the invididual archs you are changing here?
> 

Joerg,

Yes I compile tested all of them (except microblaze) on Nov 20th
linux_next git. The patch for microblaze is already in linux_next when I
tried to apply the patch to Nov 20th linux-next and figured that is
already covered and skipped that one.

-- Shuah
