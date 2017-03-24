Return-Path: <herbert@gondor.apana.org.au>
Received: from deadmen.hmeau.com (orcrist.hmeau.com [104.223.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqRBP5vhqzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 01:48:45 +1100 (AEDT)
Date: Fri, 24 Mar 2017 22:12:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 anton@samba.org, dja@axtens.net
Subject: Re: [PATCH 1/4] crypto: powerpc - Factor out the core CRC vpmsum
 algorithm
Message-ID: <20170324141219.GA14798@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170315123737.20234-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Axtens <dja@axtens.net> wrote:
> The core nuts and bolts of the crc32c vpmsum algorithm will
> also work for a number of other CRC algorithms with different
> polynomials. Factor out the function into a new asm file.
> 
> To handle multiple users of the function, a user simply
> provides constants, defines the name of their CRC function,
> and then #includes the core algorithm file.
> 
> Cc: Anton Blanchard <anton@samba.org>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

All patches applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
