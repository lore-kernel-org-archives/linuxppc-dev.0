Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (ringil.hengli.com.au [178.18.16.133])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 576132C0084
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2013 20:35:56 +1000 (EST)
Date: Mon, 2 Sep 2013 20:35:38 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 00/10] Series of fixes for NX driver
Message-ID: <20130902103538.GA815@gondor.apana.org.au>
References: <1377787000-4966-1-git-send-email-mhcerri@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377787000-4966-1-git-send-email-mhcerri@linux.vnet.ibm.com>
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

On Thu, Aug 29, 2013 at 11:36:30AM -0300, Marcelo Cerri wrote:
> This series of patches contains fixes in several algorithms implemented
> by the NX driver. The patches can be separated in three different
> categories:
>   
>  - Changes to split the data in several hyper calls to respect the
>    limits of data that the co-processador can handle. This affects
>    all AES modes.
>  - Fixes in how the driver handle zero length messages. This affects
>    XCBC and GCM.
>  - Fixes for SHA-2 when chunks bigger than the block size are provided.
> 
> v2:
>  - Fixed conflict.

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
