Return-Path: <vbabka@suse.cz>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Tb6k37X7zDr55
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 17:45:11 +1000 (AEST)
Subject: Re: [PATCH 1/2] mm/cma: remove unsupported gfp_mask parameter from
 cma_alloc()
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Michal Nazarewicz <mina86@mina86.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Chris Zankel <chris@zankel.net>, Martin Schwidefsky
 <schwidefsky@de.ibm.com>, Joerg Roedel <joro@8bytes.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Robin Murphy <robin.murphy@arm.com>,
 Laura Abbott <labbott@redhat.com>, linaro-mm-sig@lists.linaro.org
References: <20180709121956.20200-1-m.szyprowski@samsung.com>
 <CGME20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29@eucas1p2.samsung.com>
 <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7a7a88e5-e620-914c-3265-1a6383ae1974@suse.cz>
Date: Mon, 16 Jul 2018 09:45:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180709122019eucas1p2340da484acfcc932537e6014f4fd2c29~-sqTPJKij2939229392eucas1p2j@eucas1p2.samsung.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2018 02:19 PM, Marek Szyprowski wrote:
> cma_alloc() function doesn't really support gfp flags other than
> __GFP_NOWARN, so convert gfp_mask parameter to boolean no_warn parameter.
> 
> This will help to avoid giving false feeling that this function supports
> standard gfp flags and callers can pass __GFP_ZERO to get zeroed buffer,
> what has already been an issue: see commit dd65a941f6ba ("arm64:
> dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag").
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
