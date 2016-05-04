Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0Y0D5TrPzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 08:40:28 +1000 (AEST)
In-Reply-To: <20160502060052.GA12822@distroguy.com>
To: Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Remove unnecessary CONFIG_SMP #ifdefs
Message-Id: <3r0Y0D3jbYz9t5S@ozlabs.org>
Date: Thu,  5 May 2016 08:40:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-02-05 at 06:00:58 UTC, Chris Smart wrote:
> The code in machine_restart/power_off/halt() includes #ifdefs around
> calls to smp_send_stop(), however these are not required as
> include/linux/smp.h includes an empty version of this function for
> CONFIG_SMP=n builds.
> 
> Signed-off-by: Chris Smart <chris@distroguy.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/44bd82e613778f5de3fad11ed7

cheers
