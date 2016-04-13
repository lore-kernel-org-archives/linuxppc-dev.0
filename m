Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlPrs2vyQzDqBC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 23:33:33 +1000 (AEST)
In-Reply-To: <1460318028-28056-1-git-send-email-aaro.koskinen@iki.fi>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [RESEND,
 1/2] drivers: macintosh: rack-meter: limit idle ticks to total ticks
Message-Id: <3qlPrs1bdzz9t3V@ozlabs.org>
Date: Wed, 13 Apr 2016 23:33:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-10-04 at 19:53:47 UTC, Aaro Koskinen wrote:
> Limit idle ticks to total ticks. This prevents the annoying rackmeter
> leds fully ON / OFF blinking state that happens on fully idling
> G5 Xserve systems.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c796d1d97c3035cf54d4d5a9e7

cheers
