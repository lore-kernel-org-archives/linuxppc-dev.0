Return-Path: <m.szyprowski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14]) by ozlabs.org (Postfix) with ESMTP id 2F1B42C0086
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 22:07:30 +1100 (EST)
Received: from eusync1.samsung.com (mailout4.w1.samsung.com [210.118.77.14])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0ME300C9ZD4GQZ80@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 26 Nov 2012 10:57:52 +0000 (GMT)
Received: from [127.0.0.1] ([106.116.147.30])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPA id <0ME300GISD3JE210@eusync1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 26 Nov 2012 10:57:22 +0000 (GMT)
Message-id: <50B34B0F.3080204@samsung.com>
Date: Mon, 26 Nov 2012 11:57:19 +0100
From: Marek Szyprowski <m.szyprowski@samsung.com>
MIME-version: 1.0
To: shuah.khan@hp.com
Subject: Re: [PATCH 0/9] dma_debug: add debug_dma_mapping_error support to
 architectures that support DMA_DEBUG_API
References: <1353706142.5270.93.camel@lorien2>
In-reply-to: <1353706142.5270.93.camel@lorien2>
Content-type: text/plain; charset=UTF-8; format=flowed
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, a-jacquiot@ti.com,
 catalin.marinas@arm.com, Ming Lei <ming.lei@canonical.com>,
 shuahkhan@gmail.com, sparclinux@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Joerg Roedel <joro@8bytes.org>, linux-sh@vger.kernel.org, msalter@redhat.com,
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

Hello,

On 11/23/2012 10:29 PM, Shuah Khan wrote:
> An earlier patch added dma mapping error debug feature to dma_debug
> infrastructure. References:
>
> https://lkml.org/lkml/2012/10/8/296
> https://lkml.org/lkml/2012/11/3/219
>
> The following series of patches adds the call to debug_dma_mapping_error() to
> architecture specific dma_mapping_error() interfaces on the following
> architectures that support CONFIG_DMA_API_DEBUG.

I've took all the patches to the next-dma-debug branch in my tree, I sorry
that You have to wait so long for it. My branch is based on Joerg's
dma-debug branch and I've included it for testing in linux-next branch.

Joerg: would You mind if I handle pushing the whole branch to v3.8
via my kernel tree? Those changes should be kept close together to
avoid build breaks for bisecting.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
