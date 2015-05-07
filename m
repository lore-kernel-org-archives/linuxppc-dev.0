Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EDE51A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 13:12:59 +1000 (AEST)
Date: Thu, 7 May 2015 11:12:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Streetman <ddstreet@ieee.org>
Subject: Re: [PATCH 10/10] drivers/crypto/nx: add hardware 842 crypto comp alg
Message-ID: <20150507031238.GC29395@gondor.apana.org.au>
References: <1428428070-17803-1-git-send-email-ddstreet@ieee.org>
 <1430931066-4536-1-git-send-email-ddstreet@ieee.org>
 <1430931066-4536-11-git-send-email-ddstreet@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430931066-4536-11-git-send-email-ddstreet@ieee.org>
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

On Wed, May 06, 2015 at 12:51:06PM -0400, Dan Streetman wrote:
> Add crypto compression alg for 842 hardware compression and decompression.
> 
> This crypto compression alg is named "nx842" to indicate it uses hardware
> to perform the compression and decompression, while the software 842
> compression alg is named "sw842".  However, since before this split there
> was only one 842 compression alg named "842" which only used hardware,
> this is also aliased "842" for backwards compatibility.

This should still be called 842.  You can set the driver name to
nx842 or 842-nx.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
