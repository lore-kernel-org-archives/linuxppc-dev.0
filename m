Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xx0GJ3tywzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 07:56:51 +1000 (AEST)
Date: Mon, 18 Sep 2017 14:56:47 -0700 (PDT)
Message-Id: <20170918.145647.945477632021094854.davem@davemloft.net>
To: valentin.longchamp@keymile.com
Cc: leoli@freescale.com, netdev@vger.kernel.org, christophe.leroy@c-s.fr,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] net/ethernet/freescale: fix warning for ucc_geth
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170915055847.29716-1-valentin.longchamp@keymile.com>
References: <20170915055847.29716-1-valentin.longchamp@keymile.com>
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

From: Valentin Longchamp <valentin.longchamp@keymile.com>
Date: Fri, 15 Sep 2017 07:58:47 +0200

> uf_info.regs is resource_size_t i.e. phys_addr_t that can be either u32
> or u64 according to CONFIG_PHYS_ADDR_T_64BIT.
> 
> The printk format is thus adaptet to u64 and the regs value cast to u64
> to take both u32 and u64 into account.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>

Applied to net-next, thanks.
