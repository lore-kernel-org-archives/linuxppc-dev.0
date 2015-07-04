Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 755CD1A07BD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jul 2015 17:25:09 +1000 (AEST)
Date: Sat, 4 Jul 2015 15:24:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Dan Streetman <ddstreet@us.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 gustavold@linux.vnet.ibm.com
Subject: Re: [PATCH 5/6] [RFC] crypto/testmgr: add null test for 842 algorithm
Message-ID: <20150704072453.GC6153@gondor.apana.org.au>
References: <20150702223800.GA1712@linux.vnet.ibm.com>
 <20150702224119.GF1712@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150702224119.GF1712@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 02, 2015 at 03:41:19PM -0700, Nishanth Aravamudan wrote:
> Currently, when the nx-842-pseries driver loads, the following message
> is emitted:
> 
> alg: No test for 842 (842-nx)
> 
> It seems like the simplest way to fix this message (other than adding a
> proper test) is to just insert the null test into the list in the
> testmgr.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

Please add some real test vectors instead.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
