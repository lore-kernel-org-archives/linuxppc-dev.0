Return-Path: <julia.lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybpfm2dbHzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 00:45:18 +1100 (AEDT)
Date: Tue, 14 Nov 2017 14:45:08 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Colin King <colin.king@canonical.com>
cc: Haren Myneni <haren@us.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/nx: fix spelling mistake: "availavle" ->
 "available"
In-Reply-To: <20171114133346.17697-1-colin.king@canonical.com>
Message-ID: <alpine.DEB.2.20.1711141444320.2874@hadrien>
References: <20171114133346.17697-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tue, 14 Nov 2017, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in pr_err error message text
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/crypto/nx/nx-842-powernv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
> index f2246a5abcf6..9c01d11f255a 100644
> --- a/drivers/crypto/nx/nx-842-powernv.c
> +++ b/drivers/crypto/nx/nx-842-powernv.c
> @@ -744,7 +744,7 @@ static int nx842_open_percpu_txwins(void)
>
>  		if (!per_cpu(cpu_txwin, i)) {
>  			/* shoudn't happen, Each chip will have NX engine */

It could be nice to fix the comment as well: shoud -> should

julia

> -			pr_err("NX engine is not availavle for CPU %d\n", i);
> +			pr_err("NX engine is not available for CPU %d\n", i);
>  			return -EINVAL;
>  		}
>  	}
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
