Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sWyMk17JRzDs09
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Sep 2016 14:17:37 +1000 (AEST)
Date: Sat, 10 Sep 2016 21:17:28 -0700 (PDT)
Message-Id: <20160910.211728.222777942734908576.davem@davemloft.net>
To: christophe.leroy@c-s.fr
Cc: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Optimisation of fs_enet ethernet driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1473422536.git.christophe.leroy@c-s.fr>
References: <cover.1473422536.git.christophe.leroy@c-s.fr>
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

From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Fri,  9 Sep 2016 14:26:18 +0200 (CEST)

> This set optimises the freescale fs_enet ethernet driver:
> 1/ Merge of RX and TX NAPI functions in order to limit the amount of
> interrupts
> 2/ Do not unmap DMA when packets len is below copybreak, otherwise there
> is no benefit in copying the skb instead of allocating a new one
> 3/ Make copybreak value configurable as the optimised value is not the
> same on all targets

Series applied, thanks.
