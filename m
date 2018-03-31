Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0b405nhzF1pP
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:04:00 +1100 (AEDT)
In-Reply-To: <20180316201728.3377-1-aaro.koskinen@iki.fi>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: drivers: macintosh: rack-meter: really fix bogus memsets
Message-Id: <40D0b24Gsdz9s33@ozlabs.org>
Date: Sun,  1 Apr 2018 01:03:54 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-16 at 20:17:28 UTC, Aaro Koskinen wrote:
> We should zero an array using sizeof instead of number of elements.
> 
> Fixes the following compiler (GCC 7.3.0) warnings:
> 
> drivers/macintosh/rack-meter.c: In function 'rackmeter_do_pause':
> drivers/macintosh/rack-meter.c:157:2: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
> drivers/macintosh/rack-meter.c:158:2: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
> 
> Fixes: 4f7bef7a9f69 ("drivers: macintosh: rack-meter: fix bogus memsets")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e283655b5abe26462d53d5196f186c

cheers
