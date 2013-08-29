Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (ringil.hengli.com.au [178.18.16.133])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3C9742C0091
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 14:42:36 +1000 (EST)
Date: Thu, 29 Aug 2013 14:42:22 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/10] crypto: nx - fix limits to sg lists for AES-CBC
Message-ID: <20130829044221.GA25208@gondor.apana.org.au>
References: <1377288074-18998-1-git-send-email-mhcerri@linux.vnet.ibm.com>
 <1377288074-18998-4-git-send-email-mhcerri@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377288074-18998-4-git-send-email-mhcerri@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 23, 2013 at 05:01:07PM -0300, Marcelo Cerri wrote:
> This patch updates the nx-aes-cbc implementation to perform several
> hyper calls if needed in order to always respect the length limits for
> scatter/gather lists.
> 
> Two different limits are considered:
> 
>  - "ibm,max-sg-len": maximum number of bytes of each scatter/gather
>    list.
> 
>  - "ibm,max-sync-cop":
>     - The total number of bytes that a scatter/gather list can hold.
>     - The maximum number of elements that a scatter/gather list can have.
> 
> Reviewed-by: Joy Latten <jmlatten@linux.vnet.ibm.com>
> Signed-off-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>

This patch does not apply against the current cryptodev tree.

Please regenerate your pathces.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
