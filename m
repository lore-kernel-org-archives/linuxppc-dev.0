Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (ringil.hengli.com.au [178.18.16.133])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B76CD2C01BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 20:49:54 +1000 (EST)
Date: Wed, 14 Aug 2013 20:49:40 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
Subject: Re: [PATCH] crypto: nx - fix concurrency issue
Message-ID: <20130814104937.GC13403@gondor.apana.org.au>
References: <1376344177-7205-1-git-send-email-mhcerri@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376344177-7205-1-git-send-email-mhcerri@linux.vnet.ibm.com>
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

On Mon, Aug 12, 2013 at 06:49:37PM -0300, Marcelo Cerri wrote:
> The NX driver uses the transformation context to store several fields
> containing data related to the state of the operations in progress.
> Since a single tfm can be used by different kernel threads at the same
> time, we need to protect the data stored into the context.
> 
> This patch makes use of spin locks to protect the data where a race
> condition can happen.
> 
> Reviewed-by: Fionnuala Gunter <fin@linux.vnet.ibm.com>
> Reviewed-by: Joy Latten <jmlatten@linux.vnet.ibm.com>
> Signed-off-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>

Patch applied.  Thanks a lot!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
