Return-Path: <herbert@gondor.apana.org.au>
Received: from deadmen.hmeau.com (orcrist.hmeau.com [104.223.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCZKq35NPzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 02:20:30 +1100 (AEDT)
Date: Thu, 12 Oct 2017 23:19:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/18] crypto: talitos - fixes and performance improvement
Message-ID: <20171012151959.GI31122@gondor.apana.org.au>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1507284818.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 06, 2017 at 03:04:31PM +0200, Christophe Leroy wrote:
> This serie fixes and improves the talitos crypto driver.
> 
> First 6 patchs are fixes of failures reported by the new tests in the
> kernel crypto test manager.
> 
> The 8 following patches are cleanups and simplifications.
> 
> The last 4 ones are performance improvement. The main improvement is
> in the one before the last, it divides by 2 the time needed for a md5
> hash on the SEC1.
> 
> Christophe Leroy (18):
>   crypto: talitos - fix AEAD test failures
>   crypto: talitos - fix memory corruption on SEC2
>   crypto: talitos - fix setkey to check key weakness
>   crypto: talitos - fix AEAD for sha224 on non sha224 capable chips
>   crypto: talitos - fix use of sg_link_tbl_len
>   crypto: talitos - fix ctr-aes-talitos
>   crypto: talitos - zeroize the descriptor with memset()
>   crypto: talitos - declare local functions static
>   crypto: talitos - use devm_kmalloc()
>   crypto: talitos - use of_property_read_u32()
>   crypto: talitos - use devm_ioremap()
>   crypto: talitos - don't check the number of channels at each interrupt
>   crypto: talitos - remove to_talitos_ptr_len()
>   crypto: talitos - simplify tests in ipsec_esp()
>   crypto: talitos - DMA map key in setkey()
>   crypto: talitos - do hw_context DMA mapping outside the requests
>   crypto: talitos - chain in buffered data for ahash on SEC1
>   crypto: talitos - avoid useless copy

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
