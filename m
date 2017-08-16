Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTFN15pQzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:30:00 +1000 (AEST)
In-Reply-To: <87h8xat2ho.fsf@linux-m68k.org>
To: Andreas Schwab <schwab@linux-m68k.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: powerpc: fix invalid use of register expressions
Message-Id: <3xXTFM3pn0z9t4Z@ozlabs.org>
Date: Wed, 16 Aug 2017 22:29:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-14 at 18:42:43 UTC, Andreas Schwab wrote:
> This fixes another invalid use of register expressions.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6c80d3164ece26e55dc2dbfceba948

cheers
