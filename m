Return-Path: <BATV+a44557d646e720d5a26d+5259+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLMt1341HzF0T5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 18:53:45 +1100 (AEDT)
Date: Mon, 15 Jan 2018 23:53:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
 linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>,
 linux-ia64@vger.kernel.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Konrad Rzeszutek Wilk <konrad@darnok.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: consolidate swiotlb dma_map implementations
Message-ID: <20180116075338.GB12693@infradead.org>
References: <20180110080932.14157-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've pulled this into the dma-mapping for-next tree, including the
missing free_pages noted.  I'd be fine to rebase another day or two
for additional reviews or important fixes.
