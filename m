Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D08E1A0A3F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 00:49:02 +1000 (AEST)
Date: Wed, 8 Apr 2015 22:48:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Streetman <ddstreet@ieee.org>
Subject: Re: [PATCH 09/11] crypto: remove LZO fallback from crypto 842
Message-ID: <20150408144842.GA30895@gondor.apana.org.au>
References: <1428428070-17803-1-git-send-email-ddstreet@ieee.org>
 <1428428070-17803-10-git-send-email-ddstreet@ieee.org>
 <20150408141600.GA30338@gondor.apana.org.au>
 <CALZtONC0WWkfaRs+0SNHaDQ1DhT+1ekgk0YXsQBi_2NRoP1e8Q@mail.gmail.com>
 <20150408143831.GA30762@gondor.apana.org.au>
 <CALZtONAZenUKxJdzOFXe1hBxGCASO_GsVfG9vtKWBe5EwcftmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALZtONAZenUKxJdzOFXe1hBxGCASO_GsVfG9vtKWBe5EwcftmA@mail.gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, Robert Jennings <rob@pochix.net>,
 Paul Mackerras <paulus@samba.org>, linux-crypto@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Seth Jennings <sjennings@variantweb.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 08, 2015 at 10:45:45AM -0400, Dan Streetman wrote:
>
> Ok I'll see if I can include a sw compression implementation.

That would be great!

> ah ok, so you mean it can still be a crypto_comp interface, just move
> its location and/or merge it into nx-842.c?

Oh yes of course.  There is nothing wrong with it exporting this
via the crypto API.  It's just in an unusual spot for a driver.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
