Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtK5s2VfGzDqNV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 20:24:01 +1000 (AEST)
Date: Mon, 18 Jul 2016 18:23:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Kent Yoder <key@linux.vnet.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "David S. Miller" <davem@davemloft.net>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] crypto: nx - off by one bug in nx_of_update_msc()
Message-ID: <20160718102333.GC13780@gondor.apana.org.au>
References: <20160715110912.GE9258@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160715110912.GE9258@mwanda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 15, 2016 at 02:09:13PM +0300, Dan Carpenter wrote:
> The props->ap[] array is defined like this:
> 
> 	struct alg_props ap[NX_MAX_FC][NX_MAX_MODE][3];
> 
> So we can see that if msc->fc and msc->mode are == to NX_MAX_FC or
> NX_MAX_MODE then we're off by one.
> 
> Fixes: ae0222b7289d ('powerpc/crypto: nx driver code supporting nx encryption')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
