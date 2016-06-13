Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSsZZ29ylzDqZk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 22:31:02 +1000 (AEST)
Date: Mon, 13 Jun 2016 20:30:21 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Anton Blanchard <anton@ozlabs.org>
Cc: pfsmorigo@linux.vnet.ibm.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, davem@davemloft.net,
 strosake@austin.ibm.com, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] crypto: vmx: Fix ABI detection
Message-ID: <20160613123021.GC8583@gondor.apana.org.au>
References: <1465541223-17537-1-git-send-email-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465541223-17537-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 10, 2016 at 04:47:02PM +1000, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> When calling ppc-xlate.pl, we pass it either linux-ppc64 or
> linux-ppc64le. The script however was expecting linux64le, a result
> of its OpenSSL origins. This means we aren't obeying the ppc64le
> ABIv2 rules.
> 
> Fix this by checking for linux-ppc64le.
> 
> Fixes: 5ca55738201c ("crypto: vmx - comply with ABIs that specify vrsave as reserved.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anton Blanchard <anton@samba.org>

Both applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
