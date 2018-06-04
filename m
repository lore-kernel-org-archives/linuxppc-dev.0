Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4107Mw2vfGzF1Ry
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 07:28:27 +1000 (AEST)
Date: Mon, 04 Jun 2018 17:28:22 -0400 (EDT)
Message-Id: <20180604.172822.453377894759104069.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: qiang.zhao@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] wan/fsl_ucc_hdlc: use dma_zalloc_coherent
 instead of allocator/memset
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180604130759.25024-1-yuehaibing@huawei.com>
References: <20180604130759.25024-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 4 Jun 2018 21:07:59 +0800

> Use dma_zalloc_coherent instead of dma_alloc_coherent
> followed by memset 0.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
