Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 41McPS4ZNZzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2018 00:22:20 +1000 (AEST)
Subject: Re: [RFC PATCH 2/2] dma-mapping: Clean up dma_get_required_mask()
 hooks
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <55ac9550c311f056dcfeed9b2c8265375f17b155.1530726467.git.robin.murphy@arm.com>
 <08256121f325ceed7f6b88c1a5d3cf949698787d.1530726467.git.robin.murphy@arm.com>
 <20180705193846.GC28905@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <531f0a51-a58c-ab56-d05d-843f25f6dfdc@arm.com>
Date: Fri, 6 Jul 2018 15:22:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180705193846.GC28905@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/18 20:38, Christoph Hellwig wrote:
> On Wed, Jul 04, 2018 at 06:50:12PM +0100, Robin Murphy wrote:
>> As for the other mask-related hooks, standardise the arch override into
>> a Kconfig option, and also pull the generic implementation into the DMA
>> mapping code rather than having it hide away in the platform bus code.
> 
> Heh, I have a somewhat similar patch in my queue.  I didn't want it out
> because dma_get_required_mask is rather ill defined at the moment and
> I wanted to clean that up first.  But I guess I could apply this first
> and clean up later.
> 
> I just fear you might be wanting to add an arm64 user, so I'd really like
> to understand why and how.

Nah, this guy is just pure cleanup since it also fell out of my 'git 
grep ARCH_HAS_DMA'

Robin.
