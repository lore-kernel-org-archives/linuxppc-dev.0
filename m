Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3QR02xZzF1RG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:19:09 +1000 (AEST)
Date: Wed, 19 Sep 2018 21:19:05 -0700 (PDT)
Message-Id: <20180919.211905.947180004211832156.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: geoff@infradead.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, kou.ishizaki@toshiba.co.jp, andrew@lunn.ch,
 f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] net: toshiba: fix return type of
 ndo_start_xmit function
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180919102339.13988-1-yuehaibing@huawei.com>
References: <20180919102339.13988-1-yuehaibing@huawei.com>
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
Date: Wed, 19 Sep 2018 18:23:39 +0800

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
