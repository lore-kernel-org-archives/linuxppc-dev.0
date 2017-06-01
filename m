Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdxF93TDhzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 04:48:28 +1000 (AEST)
Date: Thu, 01 Jun 2017 14:48:24 -0400 (EDT)
Message-Id: <20170601.144824.1502450180029174361.davem@davemloft.net>
To: sfr@canb.auug.org.au
Cc: netdev@vger.kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, arnd@arndb.de
Subject: Re: [PATCH net-next] powerpc: use asm-generic/socket.h as much as
 possible
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170531154337.04ebcb75@canb.auug.org.au>
References: <20170531154337.04ebcb75@canb.auug.org.au>
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

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 31 May 2017 15:43:37 +1000

> asm-generic/socket.h already has an exception for the differences that
> powerpc needs, so just include it after defining the differences.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/include/uapi/asm/socket.h | 92 +---------------------------------
>  1 file changed, 1 insertion(+), 91 deletions(-)
> 
> Build tested using powerpc allyesconfig, pseries_le_defconfig, 32 bit
> and 64 bit allnoconfig and ppc44x_defconfig builds.
> 
> Dave, this is on top of the net-next tree and I am sending it to you
> since it would produce a conflict if it was merged via the powerpc tree.

Ok, I applied this to net-next, thanks Stephen!
