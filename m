Return-Path: <m.szyprowski@samsung.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wt5WK2jc9zDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 23:42:52 +1000 (AEST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0ORW0068RGAIB230@mailout2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Wed, 21 Jun 2017 14:32:42 +0100 (BST)
Subject: Re: new dma-mapping tree,
 was Re: clean up and modularize arch dma_mapping interface V2
To: Christoph Hellwig <hch@lst.de>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <5425587c-73e8-e24a-86a3-8a65a7791dcb@samsung.com>
Date: Wed, 21 Jun 2017 15:32:39 +0200
MIME-version: 1.0
In-reply-to: <20170620131623.GB30769@lst.de>
Content-type: text/plain; charset=utf-8; format=flowed
References: <20170616181059.19206-1-hch@lst.de> <20170620124140.GA27163@lst.de>
 <20170620230400.1a5ae889@canb.auug.org.au>
 <CGME20170620131628epcas1p4f21d821bd414cba7e2d49abcbe414365@epcas1p4.samsung.com>
 <20170620131623.GB30769@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christoph,

On 2017-06-20 15:16, Christoph Hellwig wrote:
> On Tue, Jun 20, 2017 at 11:04:00PM +1000, Stephen Rothwell wrote:
>> git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git#dma-mapping-next
>>
>> Contacts: Marek Szyprowski and Kyungmin Park (cc'd)
>>
>> I have called your tree dma-mapping-hch for now.  The other tree has
>> not been updated since 4.9-rc1 and I am not sure how general it is.
>> Marek, Kyungmin, any comments?
> I'd be happy to join efforts - co-maintainers and reviers are always
> welcome.

I did some dma-mapping unification works in the past and my tree in 
linux-next
was a side effect of that. I think that for now it can be dropped in 
favor of
Christoph's tree. I can also do some review and help in maintainers work if
needed, although I was recently busy with other stuff.

Christoph: Could you add me to your MAINTAINERS patch, so further 
dma-mapping
related patches hopefully will be also CC: to me?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
