Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtmXr5fg5zDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 14:00:28 +1000 (AEST)
Date: Tue, 19 Jul 2016 11:59:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: alastair@au1.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH 0/2] Automatically load the vmx_crypto module if supported
Message-ID: <20160719035939.GA20847@gondor.apana.org.au>
References: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
 <20160718102253.GA13780@gondor.apana.org.au>
 <87fur6phj0.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fur6phj0.fsf@@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 19, 2016 at 11:01:55AM +1000, Michael Ellerman wrote:
>
> Can you please ask for an ack before merging arch patches?
> 
> That's a 70 line powerpc patch and a 6 line crypto patch. It has no
> reviews and no acks. I would have preferred it if we could take it via
> the powerpc tree.

Sorry, I'll delete them from the crypto tree.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
