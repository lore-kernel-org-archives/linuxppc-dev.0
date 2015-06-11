Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id E5ECD1A07C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 08:21:28 +1000 (AEST)
Date: Thu, 11 Jun 2015 15:21:25 -0700 (PDT)
Message-Id: <20150611.152125.2297229639938532767.davem@davemloft.net>
To: fabf@skynet.be
Cc: linux-kernel@vger.kernel.org, Julia.Lawall@lip6.fr,
 pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1 linux-next] net: fs_enet: use swap() in
 fs_enet_rx_napi()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1433953999-24740-1-git-send-email-fabf@skynet.be>
References: <1433953999-24740-1-git-send-email-fabf@skynet.be>
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

From: Fabian Frederick <fabf@skynet.be>
Date: Wed, 10 Jun 2015 18:33:19 +0200

> Use kernel.h macro definition.
> 
> Thanks to Julia Lawall for Coccinelle scripting support.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Applied.
