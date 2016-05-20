Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rBPp81pyPzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 09:50:55 +1000 (AEST)
Date: Fri, 20 May 2016 19:50:51 -0400 (EDT)
Message-Id: <20160520.195051.1439037257929657896.davem@davemloft.net>
To: falakreyaz@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 christophe.jaillet@wanadoo.fr, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ps3_gelic: use kmemdup
From: David Miller <davem@davemloft.net>
In-Reply-To: <1463666090-16540-1-git-send-email-falakreyaz@gmail.com>
References: <1463666090-16540-1-git-send-email-falakreyaz@gmail.com>
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

From: Muhammad Falak R Wani <falakreyaz@gmail.com>
Date: Thu, 19 May 2016 19:24:41 +0530

> Use kmemdup when some other buffer is immediately copied into allocated
> region. It replaces call to allocation followed by memcpy, by a single
> call to kmemdup.
> 
> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>

Applied.
