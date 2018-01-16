Return-Path: <BATV+a44557d646e720d5a26d+5259+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLMs90Xk3zF0by
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 18:52:58 +1100 (AEDT)
Date: Mon, 15 Jan 2018 23:52:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
 x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>,
 linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 patches@groups.riscv.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: consolidate direct dma mapping V4
Message-ID: <20180116075243.GA12693@infradead.org>
References: <20180112084232.2857-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've pulled this into the dma-mapping for-next branch so that we get
a few days exposure before then end of the merge window.  If there is
anything important (e.g. the powerpc naming issue) please send
incremental patches.
