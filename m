Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.apana.org.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 066B61A0046
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 15:48:38 +1100 (AEDT)
Date: Fri, 6 Mar 2015 15:48:21 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@freescale.com>
Subject: Re: [PATCH v2 5/5] crypto: talitos: Add software backlog queue
 handling
Message-ID: <20150306044821.GA1411@gondor.apana.org.au>
References: <1425388897-5434-1-git-send-email-mort@bork.org>
 <1425388897-5434-6-git-send-email-mort@bork.org>
 <20150303182332.546523088b5891a776880c0f@freescale.com>
 <54F8235B.5080301@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <54F8235B.5080301@freescale.com>
Cc: Martin Hicks <mort@bork.org>, linux-crypto@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 05, 2015 at 11:35:23AM +0200, Horia Geantă wrote:
> 
> > Only potential problem is getting the crypto API to set the GFP_DMA
> > flag in the allocation request, but presumably a
> > CRYPTO_TFM_REQ_DMA crt_flag can be made to handle that.
> 
> Right. And this flag would apply only to request __ctx[].
> 
> Herbert, would this be an acceptable addition to crypto API?

How would such a flag work?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
