Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id D4EC01A09F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 03:18:16 +1100 (AEDT)
Date: Wed, 01 Apr 2015 12:18:10 -0400 (EDT)
Message-Id: <20150401.121810.1558465635261397368.davem@davemloft.net>
To: joel@jms.id.au
Subject: Re: [PATCH v2 1/3] envctrl: Ignore orderly_poweroff return value
From: David Miller <davem@davemloft.net>
In-Reply-To: <1427871888-27331-1-git-send-email-joel@jms.id.au>
References: <1427871888-27331-1-git-send-email-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, fabf@skynet.be,
 jk@ozlabs.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joel Stanley <joel@jms.id.au>
Date: Wed,  1 Apr 2015 17:34:46 +1030

> orderly_poweroff() unconditionally returns 0, so remove the dead code
> that checks the return value.
> 
> A future patch will change the return type to void.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: David S. Miller <davem@davemloft.net>
