Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybqjX3xp9zDqYR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 01:32:48 +1100 (AEDT)
Subject: Re: [PATCH] crypto/nx: fix spelling mistake: "availavle" ->
 "available"
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Haren Myneni <haren@us.ibm.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171114133346.17697-1-colin.king@canonical.com>
 <alpine.DEB.2.20.1711141444320.2874@hadrien>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <73c485d9-d59d-d552-cf4c-148f88b370ae@canonical.com>
Date: Tue, 14 Nov 2017 14:32:44 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1711141444320.2874@hadrien>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/11/17 13:45, Julia Lawall wrote:
> 
> 
> On Tue, 14 Nov 2017, Colin King wrote:
> 
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Trivial fix to spelling mistake in pr_err error message text
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/crypto/nx/nx-842-powernv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
>> index f2246a5abcf6..9c01d11f255a 100644
>> --- a/drivers/crypto/nx/nx-842-powernv.c
>> +++ b/drivers/crypto/nx/nx-842-powernv.c
>> @@ -744,7 +744,7 @@ static int nx842_open_percpu_txwins(void)
>>
>>  		if (!per_cpu(cpu_txwin, i)) {
>>  			/* shoudn't happen, Each chip will have NX engine */
> 
> It could be nice to fix the comment as well: shoud -> should

Good point. V2 sent.
> 
> julia
> 
>> -			pr_err("NX engine is not availavle for CPU %d\n", i);
>> +			pr_err("NX engine is not available for CPU %d\n", i);
>>  			return -EINVAL;
>>  		}
>>  	}
>> --
>> 2.14.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
