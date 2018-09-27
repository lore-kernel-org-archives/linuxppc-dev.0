Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LgFn3Pz6zF37k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 02:27:40 +1000 (AEST)
Date: Thu, 27 Sep 2018 18:27:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/5] dma-direct: implement complete bus_dma_mask handling
Message-ID: <20180927162737.GA11974@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-5-hch@lst.de>
 <a7626d1b-4dd8-abc4-0ab0-21ab7e5d1a4c@arm.com>
 <20180927153252.GE10566@lst.de>
 <967e98b1-99ab-8f95-4c89-6156ce489b93@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <967e98b1-99ab-8f95-4c89-6156ce489b93@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2018 at 05:14:56PM +0100, Robin Murphy wrote:
>> This just seemed more readable to me than min_not_zero, but if others
>> prefer min_not_zero I can switch.
>
> Nah, just checking whether there were any intentionally different 
> assumptions compared to the couple of other places in the patch where 
> min_not_zero() *is* used. If it's purely a style thing then no worries 
> (personally I'd have written it yet another way anyway).

I'm curious: how would you have written it?
