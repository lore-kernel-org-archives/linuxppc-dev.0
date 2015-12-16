Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id BD21F1A0B4F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 10:32:58 +1100 (AEDT)
Date: Wed, 16 Dec 2015 18:32:53 -0500 (EST)
Message-Id: <20151216.183253.313939933312742383.davem@davemloft.net>
To: martin.roth@motorolasolutions.com
Cc: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] 82xx: FCC: Fixing a bug causing to FCC port lock-up
From: David Miller <davem@davemloft.net>
In-Reply-To: <1450145874-9750-1-git-send-email-martin.roth@motorolasolutions.com>
References: <1450145874-9750-1-git-send-email-martin.roth@motorolasolutions.com>
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

From: Martin Roth <martin.roth@motorolasolutions.com>
Date: Tue, 15 Dec 2015 04:17:53 +0200

> The patch fixes FCC port lock-up, which occurs as a result of a bug
> during underrun/collision handling. Within the tx_startup() function
> in mac-fcc.c, the address of last BD is not calculated correctly.
> As a result of wrong calculation of the last BD address, the next
> transmitted BD may be set to an area out of the transmit BD ring.
> This actually causes to port lock-up and it is not recoverable.
> 
> Signed-off-by: Martin Roth <martin.roth@motorolasolutions.com>

Applied, thanks.
