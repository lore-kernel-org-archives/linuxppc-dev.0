Return-Path: <srs0=lg7u=av=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xy0G50NkCzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 23:00:13 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xy0G46vMyz8x29
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 23:00:12 +1000 (AEST)
Message-ID: <1505912404.12628.325.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/eeh: Create PHB PEs after EEH is initialized
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: Russell Currey <ruscur@au1.ibm.com>
Date: Wed, 20 Sep 2017 23:00:04 +1000
In-Reply-To: <87h8vxljpf.fsf@concordia.ellerman.id.au>
References: <1504766140.12628.14.camel@kernel.crashing.org>
 <87h8vxljpf.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-20 at 20:59 +1000, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Otherwise we end up not yet having computed the right
> > diag data size on powernv where EEH initialization
> > is delayed, thus causing memory corruption later on
> > when calling OPAL.
> 
> When did this break? Do we have a commit we can tag with Fixes: ?
> Stable?
> 
> I assume we want to merge this ASAP as a fix, I think I can safely take
> this without patch 2?

Russell, can you help Michael with that ? I don't even remember what's
in patch 2 :)

Cheers,
Ben.
