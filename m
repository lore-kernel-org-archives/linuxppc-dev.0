Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.apana.org.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B02961A092F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 22:04:18 +1000 (EST)
Date: Mon, 15 Sep 2014 19:41:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] drivers: char: hw_random: printk replacement
Message-ID: <20140915114123.GA4843@gondor.apana.org.au>
References: <1409238178-16496-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1409238178-16496-1-git-send-email-sudipm.mukherjee@gmail.com>
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

On Thu, Aug 28, 2014 at 08:32:58PM +0530, Sudip Mukherjee wrote:
> as pr_* macros are more preffered over printk, so printk replaced with corresponding pr_* macros
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Your patch doesn't even build:

  CC [M]  drivers/char/hw_random/intel-rng.o
  CC [M]  drivers/char/hw_random/amd-rng.o
  CC [M]  drivers/char/hw_random/via-rng.o
  drivers/char/hw_random/intel-rng.c: In function ‘intel_init_hw_struct’:
  drivers/char/hw_random/intel-rng.c:317:3: error: expected ‘)’ before ‘warning’
  drivers/char/hw_random/intel-rng.c:308:36: warning: unused variable ‘warning’ [-Wunused-variable]
  make[1]: *** [drivers/char/hw_random/intel-rng.o] Error 1

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
