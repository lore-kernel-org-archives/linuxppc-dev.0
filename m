Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vwSTV022SzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Apr 2017 05:04:12 +1000 (AEST)
Date: Sat, 01 Apr 2017 12:04:10 -0700 (PDT)
Message-Id: <20170401.120410.2118230452760689948.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] dpaa_eth: use AVOIDBLOCK for Tx confirmation queues
From: David Miller <davem@davemloft.net>
In-Reply-To: <1490880255-13503-1-git-send-email-madalin.bucur@nxp.com>
References: <1490880255-13503-1-git-send-email-madalin.bucur@nxp.com>
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

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Thu, 30 Mar 2017 16:24:15 +0300

> The AVOIDBLOCK flag determines the Tx confirmation queues processing
> to be redirected to any available CPU when the current one is slow
> in processing them. This may result in a higher Tx confirmation
> interrupt count but may reduce pressure on a certain CPU that with
> the previous setting would process all Tx confirmation frames.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>

Applied, thanks.
