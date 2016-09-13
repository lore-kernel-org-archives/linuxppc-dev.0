Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYTRr4xjpzDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 01:41:28 +1000 (AEST)
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by ozlabs.org (Postfix) with ESMTP id 3sYTRr2wh5z9sQw
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2016 01:41:28 +1000 (AEST)
Date: Tue, 13 Sep 2016 11:41:23 -0400 (EDT)
Message-Id: <20160913.114123.130707105572714908.davem@davemloft.net>
To: mpe@ellerman.id.au
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, arnd@arndb.de
Subject: Re: [PATCH] net: Remove NO_IRQ from powerpc-only network drivers
From: David Miller <davem@davemloft.net>
In-Reply-To: <1473501545-10134-1-git-send-email-mpe@ellerman.id.au>
References: <1473501545-10134-1-git-send-email-mpe@ellerman.id.au>
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

From: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat, 10 Sep 2016 19:59:05 +1000

> We'd like to eventually remove NO_IRQ on powerpc, so remove usages of it
> from powerpc-only drivers.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to net-next, thanks.
