Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYqKl49kkzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 22:07:55 +1100 (AEDT)
Date: Thu, 2 Mar 2017 19:07:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, davem@davemloft.net,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/2] crypto: vmx - Use skcipher for xts fallback
Message-ID: <20170302110728.GB17160@gondor.apana.org.au>
References: <20170224142734.16188-1-pfsmorigo@linux.vnet.ibm.com>
 <20170301140000.23033-1-pfsmorigo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170301140000.23033-1-pfsmorigo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 01, 2017 at 11:00:00AM -0300, Paulo Flabiano Smorigo wrote:
> Signed-off-by: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
