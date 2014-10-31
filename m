Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.apana.org.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CFAE1A01E2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 20:36:20 +1100 (AEDT)
Date: Fri, 31 Oct 2014 17:36:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH] hwrng: pseries - port to new read API and fix stack
 corruption
Message-ID: <20141031093609.GA8454@gondor.apana.org.au>
References: <20141031063233.1884.86309.stgit@bahia.local>
 <1414738812.21815.5.camel@concordia>
 <20141031103141.7b91c647@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141031103141.7b91c647@bahia.local>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 31, 2014 at 10:31:41AM +0100, Greg Kurz wrote:
>
> > > Cc'ing stable as I could reproduce back to 3.15.10
> > 
> > The right way to CC stable for a patch that isn't yet in upstream is to add:
> > 
> > CC: stable@vger.kernel.org
> > 
> > Before your Signed-off-by. They will then pick it up once it's merged into
> > Linus' tree. See Documentation/stable_kernel_rules.txt
> > 
> > cheers
> > 
> 
> Oops... should I repost then ?

Don't worry, I can fix this up.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
