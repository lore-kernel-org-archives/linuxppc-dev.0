Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sqrLp6mpkzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 11:41:54 +1100 (AEDT)
Date: Thu, 06 Oct 2016 20:41:50 -0400 (EDT)
Message-Id: <20161006.204150.1012475185723412636.davem@davemloft.net>
To: colin.king@canonical.com
Cc: geoff@infradead.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ps3_gelic: Add missing \n to end of deb_dbg message
From: David Miller <davem@davemloft.net>
In-Reply-To: <20161004111554.11881-1-colin.king@canonical.com>
References: <20161004111554.11881-1-colin.king@canonical.com>
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

From: Colin King <colin.king@canonical.com>
Date: Tue,  4 Oct 2016 12:15:54 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trival fix, dev_dbg message is missing a \n, so add it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
