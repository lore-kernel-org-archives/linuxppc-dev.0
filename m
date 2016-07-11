Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp1L032WNzDqyC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 20:19:36 +1000 (AEST)
In-Reply-To: <1467607904.13965.1.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: powerpc/opal: Wake up kopald polling thread before waiting for
 events
Message-Id: <3rp1Kz6jyyz9t1G@ozlabs.org>
Date: Mon, 11 Jul 2016 20:19:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-04-07 at 04:51:44 UTC, Benjamin Herrenschmidt wrote:
> On some environments (prototype machines, some simulators, etc...)
> there is no functional interrupt source to signal completion, so
> we rely on the fairly slow OPAL heartbeat.
> 
> In a number of cases, the calls complete very quickly or even
> immediately. We've observed that it helps a lot to wakeup the OPAL
> heartbeat thread before waiting for event in those cases, it will
> call OPAL immediately to collect completions for anything that
> finished fast enough.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Acked-By: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a203658b5ed37c11e5016d3fbb

cheers
