Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybwmC6Ny2zDqkr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 05:20:25 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAEIKFU8102180
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 13:20:20 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e83530fns-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 13:20:19 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Tue, 14 Nov 2017 11:20:18 -0700
Date: Tue, 14 Nov 2017 10:20:03 -0800
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Colin King <colin.king@canonical.com>
CC: Haren Myneni <haren@us.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] crypto/nx: fix spelling mistake: "availavle" ->
 "available"
References: <20171114143217.21456-1-colin.king@canonical.com>
In-Reply-To: <20171114143217.21456-1-colin.king@canonical.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <5A0B33D3.4010707@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry for my mistake. Thanks. 

Acked-by: Haren Myneni <haren@us.ibm.com> 

On 11/14/2017 06:32 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in pr_err error message text. Also
> fix spelling mistake in proceeding comment.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/crypto/nx/nx-842-powernv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
> index f2246a5abcf6..1e87637c412d 100644
> --- a/drivers/crypto/nx/nx-842-powernv.c
> +++ b/drivers/crypto/nx/nx-842-powernv.c
> @@ -743,8 +743,8 @@ static int nx842_open_percpu_txwins(void)
>  		}
> 
>  		if (!per_cpu(cpu_txwin, i)) {
> -			/* shoudn't happen, Each chip will have NX engine */
> -			pr_err("NX engine is not availavle for CPU %d\n", i);
> +			/* shouldn't happen, Each chip will have NX engine */
> +			pr_err("NX engine is not available for CPU %d\n", i);
>  			return -EINVAL;
>  		}
>  	}
> 
