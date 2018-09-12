Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429B3n6TTzzF31w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 16:01:08 +1000 (AEST)
Date: Tue, 11 Sep 2018 23:01:05 -0700 (PDT)
Message-Id: <20180911.230105.563027666901362955.davem@davemloft.net>
To: lucien.xin@gmail.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 christophe.leroy@c-s.fr, mpe@ellerman.id.au, roopa@cumulusnetworks.com
Subject: Re: [PATCH net] powerpc: use big endian to hash len and proto in
 csum_ipv6_magic
From: David Miller <davem@davemloft.net>
In-Reply-To: <9183876a4a8ff0099686521d60f395a5230b67ed.1536401712.git.lucien.xin@gmail.com>
References: <9183876a4a8ff0099686521d60f395a5230b67ed.1536401712.git.lucien.xin@gmail.com>
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

From: Xin Long <lucien.xin@gmail.com>
Date: Sat,  8 Sep 2018 18:15:12 +0800

> The function csum_ipv6_magic doesn't convert len and proto to big
> endian before doing ipv6 csum hash, which is not consistent with
> RFC and other arches.
> 
> Jianlin found it when ICMPv6 packets from other hosts were dropped
> in the powerpc64 system.
> 
> This patch is to fix it by using instruction 'lwbrx' to do this
> conversion in powerpc32/64 csum_ipv6_magic.
> 
> Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
> Reported-by: Jianlin Shi <jishi@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Xin, please address the feedback you were given.

Thank you.
