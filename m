Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rzXlk5ZbqzDqcn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 08:26:26 +1000 (AEST)
Date: Tue, 26 Jul 2016 15:26:24 -0700 (PDT)
Message-Id: <20160726.152624.1129190524778208462.davem@davemloft.net>
To: dan.carpenter@oracle.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] ide: missing break statement in set_timings_mdma()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160714104802.GI18175@mwanda>
References: <20160714104802.GI18175@mwanda>
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

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 14 Jul 2016 13:48:02 +0300

> There was clearly supposed to be a break statement here.  Currently we
> use the k2 ata timings instead of sh ata ones we intended.  Probably no
> one has this hardware anymore so it likely doesn't make a difference
> beyond the static checker warning.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.
