Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41YXmW4v22zDqmj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 04:13:14 +1000 (AEST)
Date: Sun, 22 Jul 2018 11:13:06 -0700 (PDT)
Message-Id: <20180722.111306.1387292994024366959.davem@davemloft.net>
To: rdunlap@infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, netdev@vger.kernel.org
Subject: Re: [PATCH] net: prevent ISA drivers from building on PPC32
From: David Miller <davem@davemloft.net>
In-Reply-To: <b7e66624-a077-048a-d8f5-52a3722157df@infradead.org>
References: <b7e66624-a077-048a-d8f5-52a3722157df@infradead.org>
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

From: Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 21 Jul 2018 12:59:25 -0700

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Prevent drivers from building on PPC32 if they use isa_bus_to_virt(),
> isa_virt_to_bus(), or isa_page_to_bus(), which are not available and
> thus cause build errors.
 ...
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>

Applied, thanks Randy.
