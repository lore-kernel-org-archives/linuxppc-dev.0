Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYPy06zQYzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 23:03:52 +1000 (AEST)
Date: Tue, 13 Sep 2016 20:39:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: olof@lixom.net, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, mpm@selenic.com
Subject: Re: [PATCH] hwrng: pasemi-rng - Use linux/io.h instead of asm/io.h
Message-ID: <20160913123919.GA31835@gondor.apana.org.au>
References: <1473150519-30931-1-git-send-email-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473150519-30931-1-git-send-email-prasannatsmkumar@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 06, 2016 at 01:58:39PM +0530, PrasannaKumar Muralidharan wrote:
> Checkpatch.pl warns about usage of asm/io.h. Use linux/io.h instead.
> 
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
