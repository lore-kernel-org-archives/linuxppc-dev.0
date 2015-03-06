Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.apana.org.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E5251A0371
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 11:29:11 +1100 (AEDT)
Date: Fri, 6 Mar 2015 11:28:31 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 0/17] crypto: talitos - Add support for SEC1
Message-ID: <20150306002831.GA30947@gondor.apana.org.au>
References: <20150305164605.E65D81A241C@localhost.localdomain>
 <20150305182101.6db66e228f519476f0751c13@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150305182101.6db66e228f519476f0751c13@freescale.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-crypto@vger.kernel.org, Kumar Gala <galak@codeaurora.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 05, 2015 at 06:21:01PM -0600, Kim Phillips wrote:
> On Thu, 5 Mar 2015 17:46:05 +0100
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
> > [15/17] crypto: talitos - Implementation of SEC1
> 
> ...
> 
> > [16/17] crypto: talitos - SEC1 bugs on 0 data hash
> > [17/17] crypto: talitos - Update DT bindings with SEC1
> 
> This patchseries doesn't apply, at least on top of Herbert's
> cryptodev-2.6 tree, as of today:
> 
> Applying: crypto: talitos - Implementation of SEC1
> error: patch failed: drivers/crypto/talitos.c:655
> error: drivers/crypto/talitos.c: patch does not apply

Also the patches are coming in a random order.  Please send them
one at a time to ensure proper ordering.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
