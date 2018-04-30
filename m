Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZQQS3MyKzF2Pp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 23:30:19 +1000 (AEST)
Date: Mon, 30 Apr 2018 09:30:13 -0400 (EDT)
Message-Id: <20180430.093013.1145501356576833835.davem@davemloft.net>
To: colin.king@canonical.com
Cc: leoyang.li@nxp.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ucc: fix spelling mistake:
 "tx-late-collsion" -> "tx-late-collision"
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180428095707.7424-1-colin.king@canonical.com>
References: <20180428095707.7424-1-colin.king@canonical.com>
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
Date: Sat, 28 Apr 2018 10:57:07 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in tx_fw_stat_gstrings text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
