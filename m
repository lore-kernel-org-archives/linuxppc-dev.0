Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 47D502C0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 16:05:48 +1000 (EST)
Date: Wed, 19 Jun 2013 23:05:46 -0700 (PDT)
Message-Id: <20130619.230546.1612893804152231671.davem@davemloft.net>
To: rusty@rustcorp.com.au
Subject: Re: [PATCH 2/9] PTR_RET is now PTR_ERR_OR_ZERO(): Replace most.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1371357768-4968-2-git-send-email-rusty@rustcorp.com.au>
References: <87ehc2rczo.fsf@rustcorp.com.au>
 <1371357768-4968-1-git-send-email-rusty@rustcorp.com.au>
 <1371357768-4968-2-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 julia.lawall@lip6.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Sun, 16 Jun 2013 14:12:41 +0930

> Sweep of the simple cases.
> 
> Cc: netdev@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Acked-by: David S. Miller <davem@davemloft.net>
