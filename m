Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D3ED1A006F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 14:26:18 +1000 (AEST)
Date: Mon, 18 May 2015 12:25:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH 1/6] crypto: md5: add MD5 initial vectors
Message-ID: <20150518042554.GB13238@gondor.apana.org.au>
References: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
Cc: linux-mips@linux-mips.org, aaro.koskinen@iki.fi,
 linux-kernel@vger.kernel.org, ralf@linux-mips.org, paulus@samba.org,
 linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 17, 2015 at 12:54:12PM +0200, LABBE Corentin wrote:
> This patch simply adds the MD5 IV in the md5 header.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
