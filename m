Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14E0267B5C
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 13:54:13 +1000 (EST)
Date: Thu, 31 Aug 2006 13:53:46 +1000
To: Paul Mackerras <paulus@samba.org>
Subject: Re: IPSec kernel oops on ppc64
Message-ID: <20060831035346.GA28306@gondor.apana.org.au>
References: <200608301636.k7UGaQY5002569@faith.austin.ibm.com>
	<20060831015942.GA27423@gondor.apana.org.au>
	<17654.21983.691176.397891@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17654.21983.691176.397891@cargo.ozlabs.ibm.com>
From: Herbert Xu <herbert@gondor.apana.org.au>
Cc: jmorris@redhat.com, netdev@vger.kernel.org, anton@au1.ibm.com,
	linuxppc-dev@ozlabs.org, gcwilson@us.ibm.com,
	Joy Latten <latten@austin.ibm.com>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul:

On Thu, Aug 31, 2006 at 01:22:07PM +1000, Paul Mackerras wrote:
> 
> You missed a couple of 'beqlr' instructions (branch if equal to LR).
> I'd be interested to know if it still fails with the patch below.

Yes that'd do it.

BTW, did you see the "cmpldi r1,..." stuff in the code?  That's a typo,
right?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
