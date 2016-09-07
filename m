Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTkfS6MKFzDsFT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 23:22:40 +1000 (AEST)
Date: Wed, 7 Sep 2016 21:22:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: olof@lixom.net, mpm@selenic.com, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, darren@stevens-zone.net,
 clabbe.montjoie@gmail.com
Subject: Re: [PATCH v2] hwrng: pasemi_rng.c: Migrate to managed API
Message-ID: <20160907132210.GL17176@gondor.apana.org.au>
References: <1473012788-6262-1-git-send-email-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473012788-6262-1-git-send-email-prasannatsmkumar@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 04, 2016 at 11:43:08PM +0530, PrasannaKumar Muralidharan wrote:
> Use devm_ioremap and devm_hwrng_register instead of ioremap and
> hwrng_register. This removes unregistering and error handling code.
> 
> Changes in v2:
> Remove hardcoded resource size in ioremap, use resource struct obtained
> by calling platform_get_resource.
> 
> Removing hardcoded resource size was suggested by LABBE Corentin.
> 
> CC: Darren Stevens <darren@stevens-zone.net>
> 
> Suggested-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
