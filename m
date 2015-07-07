Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E56F1A107B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 00:01:52 +1000 (AEST)
Date: Tue, 7 Jul 2015 22:01:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Dan Streetman <ddstreet@us.ibm.com>, linux-crypto@vger.kernel.org,
 gustavold@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2] crypto/nx-842-{powerpc, pseries}: reduce chattiness of
 platform drivers
Message-ID: <20150707140137.GA3351@gondor.apana.org.au>
References: <20150702223800.GA1712@linux.vnet.ibm.com>
 <20150702224049.GE1712@linux.vnet.ibm.com>
 <1435887032.3665.1.camel@ellerman.id.au>
 <20150706170621.GA3578@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150706170621.GA3578@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 06, 2015 at 10:06:21AM -0700, Nishanth Aravamudan wrote:
>
> v2:
>   Rather than not loading, just reduce the verbosity

Applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
