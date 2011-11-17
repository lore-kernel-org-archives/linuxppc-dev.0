Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9F535B71C4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 12:37:32 +1100 (EST)
Date: Wed, 16 Nov 2011 20:35:27 -0500 (EST)
Message-Id: <20111116.203527.1216342714272524865.davem@davemloft.net>
To: joe@perches.com
Subject: Re: [PATCH net-next 0/5] Use ETH_ALEN
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1321472142.git.joe@perches.com>
References: <cover.1321472142.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Joe Perches <joe@perches.com>
Date: Wed, 16 Nov 2011 11:38:01 -0800

> Remove other #defines and uses in favor of ETH_ALEN
> 
> Joe Perches (5):
>   ethernet: Convert MAC_ADDR_LEN uses to ETH_ALEN
>   ethernet: Convert ETHER_ADDR_LEN uses to ETH_ALEN
>   bna: Convert MAC_ADDRLEN uses to ETH_ALEN
>   amd8111e:  Convert ETH_ADDR_LEN uses to ETH_ALEN
>   ucc_geth: Convert ENET_NUM_OCTETS_PER_ADDRESS uses to ETH_ALEN

All applied, thanks Joe.
