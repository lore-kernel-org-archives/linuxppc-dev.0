Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJq1h058gzDqc6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:08:04 +1000 (AEST)
Date: Tue, 31 May 2016 17:46:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Kim Phillips <kim.phillips@arm.com>,
 David S Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 2/6] crypto: talitos - making mapping helpers more generic
Message-ID: <20160531094651.GA15187@gondor.apana.org.au>
References: <cover.1464330501.git.christophe.leroy@c-s.fr>
 <26474a2b44e69a0dbff43dbeed030ab5adef81db.1464330501.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <26474a2b44e69a0dbff43dbeed030ab5adef81db.1464330501.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 27, 2016 at 11:32:36AM +0200, Christophe Leroy wrote:
>
> +	sg_count = sg_to_link_tbl_offset(src, sg_count, offset, len,
> +					 &edesc->link_tbl[tbl_off])
> +	if (sg_count == 1) {
> +		/* Only one segment now, so no link tbl needed*/
> +		copy_talitos_ptr(ptr, &edesc->link_tbl[tbl_off], is_sec1);
> +		return sg_count;
> +	}

This patch doesn't build.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
