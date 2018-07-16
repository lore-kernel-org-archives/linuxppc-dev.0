Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41TwqF2YWyzF35t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 07:03:04 +1000 (AEST)
Date: Mon, 16 Jul 2018 14:03:00 -0700 (PDT)
Message-Id: <20180716.140300.318968566584687896.davem@davemloft.net>
To: rdunlap@infradead.org
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] net/ethernet/freescale/fman: fix cross-build error
From: David Miller <davem@davemloft.net>
In-Reply-To: <3a063d78-73f8-b41f-9354-fe839fe80c11@infradead.org>
References: <3a063d78-73f8-b41f-9354-fe839fe80c11@infradead.org>
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

From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 13 Jul 2018 21:25:19 -0700

> From: Randy Dunlap <rdunlap@infradead.org>
> 
>   CC [M]  drivers/net/ethernet/freescale/fman/fman.o
> In file included from ../drivers/net/ethernet/freescale/fman/fman.c:35:
> ../include/linux/fsl/guts.h: In function 'guts_set_dmacr':
> ../include/linux/fsl/guts.h:165:2: error: implicit declaration of function 'clrsetbits_be32' [-Werror=implicit-function-declaration]
>   clrsetbits_be32(&guts->dmacr, 3 << shift, device << shift);
>   ^~~~~~~~~~~~~~~
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied.
