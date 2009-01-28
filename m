Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	by ozlabs.org (Postfix) with ESMTP id 5903CDDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 14:59:56 +1100 (EST)
Date: Wed, 28 Jan 2009 14:59:37 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
To: James Hsiao <jhsiao@amcc.com>
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v5
Message-ID: <20090128035937.GA13157@gondor.apana.org.au>
References: <1231788650.5533.16.camel@jhsiao-usb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1231788650.5533.16.camel@jhsiao-usb>
Cc: linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 12, 2009 at 11:30:50AM -0800, James Hsiao wrote:
> This is the 5th submission of AMCC's security driver.
> - remove aad support in build pd function, since we didn't release any
> algorithm that use aead yet.
> 
> - changed some hardcode value to #defines
> 
> - changed local_irq_disable/enable to spinlock_irq_save/restore
> 
> - fixed bug in crypto4xx_probe on error exit.
> 
> 
> Signed-off-by: James Hsiao <jhsiao@amcc.com>

I was going to apply this but you didn't give me a changelog
that I can throw into the tree without feeling guilty!

Please always attach a proper changelog with each submission
so I don't have to do this.  You can put the changelog elsewhere
in the email.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
