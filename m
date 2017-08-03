Return-Path: <herbert@gondor.apana.org.au>
Received: from deadmen.hmeau.com (orcrist.hmeau.com [104.223.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNKlf12mtzDrG3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 16:24:30 +1000 (AEST)
Date: Thu, 3 Aug 2017 13:58:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 benh@kernel.crashing.org, suka@us.ibm.com, ddstreet@ieee.org,
 linuxram@us.ibm.com, npiggin@gmail.com, hbabu@us.ibm.com
Subject: Re: [PATCH V3 2/6] crypto/nx: Create nx842_configure_crb function
Message-ID: <20170803055850.GA11987@gondor.apana.org.au>
References: <1500699459.23205.3.camel@hbabu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500699459.23205.3.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 21, 2017 at 09:57:39PM -0700, Haren Myneni wrote:
> 
> Configure CRB is moved to nx842_configure_crb() so that it can
> be used for icswx and VAS exec functions. VAS function will be
> added later with P9 support.
> 
> Signed-off-by: Haren Myneni <haren@us.ibm.com>

Your patch does not apply against cryptodev.  Please rebase.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
