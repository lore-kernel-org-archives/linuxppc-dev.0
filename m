Return-Path: <herbert@gondor.apana.org.au>
Received: from ringil.hengli.com.au (ringil.hengli.com.au [178.18.16.133])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B8D221A0008
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 21:33:32 +1100 (AEDT)
Date: Mon, 9 Mar 2015 21:08:26 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] crypto: powerpc - move files to fix build error
Message-ID: <20150309100826.GE4452@gondor.apana.org.au>
References: <20150306184621.c2d277457bb1b3112b1d3a64@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150306184621.c2d277457bb1b3112b1d3a64@freescale.com>
Cc: linux-kernel@vger.kernel.org, Markus Stockhausen <stockhausen@collogia.de>,
 linux-crypto@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 06, 2015 at 06:46:21PM -0600, Kim Phillips wrote:
> The current cryptodev-2.6 tree commits:
> 
> d9850fc529ef ("crypto: powerpc/sha1 - kernel config")
> 50ba29aaa7b0 ("crypto: powerpc/sha1 - glue")
> 
> failed to properly place files under arch/powerpc/crypto, which
> leads to build errors:
> 
> make[1]: *** No rule to make target 'arch/powerpc/crypto/sha1-spe-asm.o', needed by 'arch/powerpc/crypto/sha1-ppc-spe.o'.  Stop.
> make[1]: *** No rule to make target 'arch/powerpc/crypto/sha1_spe_glue.o', needed by 'arch/powerpc/crypto/sha1-ppc-spe.o'.  Stop.
> Makefile:947: recipe for target 'arch/powerpc/crypto' failed
> 
> Move the two sha1 spe files under crypto/, and whilst there, rename
> other powerpc crypto files with underscores to use dashes for
> consistency.
> 
> Cc: Markus Stockhausen <stockhausen@collogia.de>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
