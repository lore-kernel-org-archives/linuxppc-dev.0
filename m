Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6681E1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 13:07:44 +1000 (AEST)
Date: Thu, 7 May 2015 11:07:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Streetman <ddstreet@ieee.org>
Subject: Re: [PATCH 04/10] crypto: change 842 alg to use software
Message-ID: <20150507030717.GB29395@gondor.apana.org.au>
References: <1428428070-17803-1-git-send-email-ddstreet@ieee.org>
 <1430931066-4536-1-git-send-email-ddstreet@ieee.org>
 <1430931066-4536-5-git-send-email-ddstreet@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430931066-4536-5-git-send-email-ddstreet@ieee.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 Robert Jennings <rob@pochix.net>, Paul Mackerras <paulus@samba.org>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Seth Jennings <sjennings@variantweb.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 06, 2015 at 12:51:00PM -0400, Dan Streetman wrote:
> Change the crypto 842 compression alg to use the software 842 compression
> and decompression library.  Change the name of this crypto alg to "sw842".
> Remove the fallback to LZO compression.

That's not how the name works.  All implementations of 842 should
bear that name.  They should differentiate themselves based on
cra_driver_name.  For example, we generally call the software
implementation of foo "foo-generic".

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
