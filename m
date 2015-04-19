Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.hengli.com.au (helcar.hengli.com.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C8E811A0023
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2015 15:49:38 +1000 (AEST)
Date: Sun, 19 Apr 2015 13:48:47 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3 00/17] crypto: talitos - Add support for SEC1
Message-ID: <20150419054847.GB11255@gondor.apana.org.au>
References: <20150417143147.154871A242C@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150417143147.154871A242C@localhost.localdomain>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kim Phillips <kim.phillips@freescale.com>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-crypto@vger.kernel.org,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2015 at 04:31:47PM +0200, Christophe Leroy wrote:
> The purpose of this set of patchs is to add to talitos crypto driver
> the support for the SEC1 version of the security engine, which is
> found in mpc885 and mpc8272 processors.
> 
> v3 is a complete rework of the patchset. Since a kernel can be built
> with support for both MPC82xx and MPC83xx at the same time, talitos
> driver shall support both SEC1 and SEC2+ at the same time.
> 
> Based on cryptodev-2.6 tree

All applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
