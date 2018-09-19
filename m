Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FlGJ012fzDqjv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 02:11:02 +1000 (AEST)
Subject: Re: [PATCH net-next] net: toshiba: fix return type of ndo_start_xmit
 function
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 kou.ishizaki@toshiba.co.jp, andrew@lunn.ch, f.fainelli@gmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20180919102339.13988-1-yuehaibing@huawei.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <44f9d0cf-e842-696a-2e49-e16643ea668e@infradead.org>
Date: Wed, 19 Sep 2018 09:10:46 -0700
MIME-Version: 1.0
In-Reply-To: <20180919102339.13988-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Yue, 

On 09/19/2018 03:23 AM, YueHaibing wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I tested this against Linux-4.19-rc4, and it seemed to work OK.

Please remove the irrelevant line 'Found by coccinelle.' from the
commit message.  With that change:

  Acked-by: Geoff Levand <geoff@infradead.org>

-Geoff
