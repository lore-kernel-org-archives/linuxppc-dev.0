Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bRx92dZlzF09c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 06:42:19 +1000 (AEST)
Date: Wed, 25 Jul 2018 13:42:11 -0700 (PDT)
Message-Id: <20180725.134211.849330522483481967.davem@davemloft.net>
To: krzk@kernel.org
Cc: pantelis.antoniou@gmail.com, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ebiggers3@gmail.com
Subject: Re: [PATCH] net: ethernet: fs-enet: Use generic CRC32 implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180723162020.6221-1-krzk@kernel.org>
References: <20180723162020.6221-1-krzk@kernel.org>
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

From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 23 Jul 2018 18:20:20 +0200

> Use generic kernel CRC32 implementation because it:
> 1. Should be faster (uses lookup tables),
> 2. Removes duplicated CRC generation code,
> 3. Uses well-proven algorithm instead of coding it one more time.
> 
> Suggested-by: Eric Biggers <ebiggers3@gmail.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied.
