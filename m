Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65ACB1A08FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 00:16:33 +1000 (AEST)
Date: Wed, 8 Apr 2015 22:16:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Streetman <ddstreet@ieee.org>
Subject: Re: [PATCH 09/11] crypto: remove LZO fallback from crypto 842
Message-ID: <20150408141600.GA30338@gondor.apana.org.au>
References: <1428428070-17803-1-git-send-email-ddstreet@ieee.org>
 <1428428070-17803-10-git-send-email-ddstreet@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428428070-17803-10-git-send-email-ddstreet@ieee.org>
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

On Tue, Apr 07, 2015 at 01:34:28PM -0400, Dan Streetman wrote:
> Update the crypto 842 driver to no longer fallback to LZO if the 842
> hardware is unavailable.  Simplify the crpypto 842 driver to remove all
> headers indicating 842/lzo.
> 
> The crypto 842 driver should do 842-format compression and decompression
> only.  It should not fallback to LZO compression/decompression.  The
> user of the crypto 842 driver can fallback to another format if desired.
> 
> Signed-off-by: Dan Streetman <ddstreet@ieee.org>

Thanks for the series.  I don't know how I missed it when it was
merged originally but crypto/842.c needs to be moved over to
drivers/crypto.  Your software implementation should take its
places as the reference implementation.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
