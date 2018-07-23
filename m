Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z8bS1pnpzDqmj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 04:07:31 +1000 (AEST)
Date: Mon, 23 Jul 2018 11:07:26 -0700 (PDT)
Message-Id: <20180723.110726.835170464043859135.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: qiang.zhao@nxp.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] wan/fsl_ucc_hdlc: use IS_ERR_VALUE() to check
 return value of qe_muram_alloc
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180723141233.19948-1-yuehaibing@huawei.com>
References: <20180723141233.19948-1-yuehaibing@huawei.com>
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
Date: Mon, 23 Jul 2018 22:12:33 +0800

> qe_muram_alloc return a unsigned long integer,which should not
> compared with zero. check it using IS_ERR_VALUE() to fix this.
> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
