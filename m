Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 193E71A1D04
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 05:05:51 +1000 (AEST)
Date: Tue, 11 Aug 2015 12:05:49 -0700 (PDT)
Message-Id: <20150811.120549.725041722027995104.davem@davemloft.net>
To: christophe.leroy@c-s.fr
Cc: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] net: fs_enet: mask interrupts for TX partial frames.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20150811101103.045721A2414@localhost.localdomain>
References: <20150811101103.045721A2414@localhost.localdomain>
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
Date: Tue, 11 Aug 2015 12:11:03 +0200 (CEST)

> We are not interested in interrupts for partially transmitted frames.
> Unlike SCC and FCC, the FEC doesn't handle the I bit in buffer
> descriptors, instead it defines two interrupt bits, TXB and TXF.
> 
> We have to mask TXB in order to only get interrupts once the
> frame is fully transmitted.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied.
