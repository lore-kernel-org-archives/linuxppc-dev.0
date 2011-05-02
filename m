Return-Path: <herbert@gondor.apana.org.au>
Received: from fornost.hengli.com.au (helcar.apana.org.au [209.40.204.226])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3CE2FB6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 09:56:19 +1000 (EST)
Date: Tue, 3 May 2011 09:56:02 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/4] crypto: caam - handle interrupt lines shared
	across rings
Message-ID: <20110502235602.GA26670@gondor.apana.org.au>
References: <20110411191516.bae0454e.kim.phillips@freescale.com>
	<20110415095049.GA2129@gondor.apana.org.au>
	<20110502182727.366857bd.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110502182727.366857bd.kim.phillips@freescale.com>
Cc: Steve Cornelius <sec@pobox.com>, linuxppc-dev@lists.ozlabs.org,
	linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 02, 2011 at 06:27:27PM -0500, Kim Phillips wrote:
>
> I don't see them in cryptodev-2.6 - did you forget to push them?

Indeed, they were stuck on my other machine.  They should be on
master now and should show up on the public mirror soon.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
