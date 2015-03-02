Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.apana.org.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 699571A0196
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 21:26:12 +1100 (AEDT)
Date: Mon, 2 Mar 2015 23:25:59 +1300
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Markus Stockhausen <stockhausen@collogia.de>
Subject: Re: [v1,1/3] crypto: powerpc/sha1 - assembler
Message-ID: <20150302102559.GA24450@gondor.apana.org.au>
References: <ce3e5ff2-5904-4e1c-bfa9-e37c9682f961@EXCHANGE.collogia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ce3e5ff2-5904-4e1c-bfa9-e37c9682f961@EXCHANGE.collogia.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 24, 2015 at 08:36:40PM +0100, Markus Stockhausen wrote:
> This is the assembler code for SHA1 implementation with
> the SIMD SPE instruction set. With the enhanced instruction 
> set we can operate on 2 32 bit words in parallel. That helps 
> reducing the time to calculate W16-W79. For increasing 
> performance even more the assembler function can compute 
> hashes for more than one 64 byte input block. 
> 
> The state of the used SPE registers is preserved via the 
> stack so we can run from interrupt context. There might 
> be the case that we interrupt ourselves and push sensitive 
> data from another context onto our stack. Clear this area
> in the stack afterwards to avoid information leakage.
> 
> The code is endian independant.
> 
> Signed-off-by: Markus Stockhausen <stockhausen@collogia.de>

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
