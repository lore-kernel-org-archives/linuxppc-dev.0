Return-Path: <sudipm.mukherjee@gmail.com>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C4D91A00C7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 22:03:19 +1000 (EST)
Received: by mail-pa0-f46.google.com with SMTP id kq14so6284165pab.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 05:03:17 -0700 (PDT)
Date: Mon, 15 Sep 2014 17:33:03 +0530
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] drivers: char: hw_random: printk replacement
Message-ID: <20140915120303.GA27044@sudip-PC>
References: <1409238178-16496-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20140915114123.GA4843@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140915114123.GA4843@gondor.apana.org.au>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-geode@lists.infradead.org,
 Matt Mackall <mpm@selenic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 15, 2014 at 07:41:23PM +0800, Herbert Xu wrote:
> On Thu, Aug 28, 2014 at 08:32:58PM +0530, Sudip Mukherjee wrote:
> > as pr_* macros are more preffered over printk, so printk replaced with corresponding pr_* macros
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> 
> Your patch doesn't even build:
> 
>   CC [M]  drivers/char/hw_random/intel-rng.o
>   CC [M]  drivers/char/hw_random/amd-rng.o
>   CC [M]  drivers/char/hw_random/via-rng.o
>   drivers/char/hw_random/intel-rng.c: In function ‘intel_init_hw_struct’:
>   drivers/char/hw_random/intel-rng.c:317:3: error: expected ‘)’ before ‘warning’
>   drivers/char/hw_random/intel-rng.c:308:36: warning: unused variable ‘warning’ [-Wunused-variable]
>   make[1]: *** [drivers/char/hw_random/intel-rng.o] Error 1
> 
> Cheers,
> -- 

i am extremely sorry for the mess. after applying the patch i tested with allmodconfig
and seeing no error i thought it was ok. but now after your mail when i am verifying i
noticed that allmodconfig is not including it in the config and as a result it was not tested.

i will post a corrected v2 of the patch.

sorry again,

thanks
sudip


> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
