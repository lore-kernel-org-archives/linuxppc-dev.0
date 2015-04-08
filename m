Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 254471A0BD9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 00:16:54 +1000 (AEST)
Date: Wed, 8 Apr 2015 22:16:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Streetman <ddstreet@ieee.org>
Subject: Re: [PATCH 11/11] crypto: add crypto compression sefltest
Message-ID: <20150408141631.GB30338@gondor.apana.org.au>
References: <1428428070-17803-1-git-send-email-ddstreet@ieee.org>
 <1428428070-17803-12-git-send-email-ddstreet@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428428070-17803-12-git-send-email-ddstreet@ieee.org>
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

On Tue, Apr 07, 2015 at 01:34:30PM -0400, Dan Streetman wrote:
> Add configurable module to perform self-tests on any crypto compression
> driver.
> 
> This allows testing any crypto compression driver with any input buffer,
> at varying alignments and lengths.  It calculates the average bytes per
> second compression and decompression rates.  Any errors reported by the
> compressor during compression or decompression will end the test and
> be logged.
> 
> Signed-off-by: Dan Streetman <ddstreet@ieee.org>

Please use the existing infrastructure in testmgr/tcrypt.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
