Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyNQC5hPtzDr3l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 23:08:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, Oliver O'Halloran <oohall@gmail.com>,
 akpm@linux-foundation.org <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/6] mm, x86: Add ARCH_HAS_ZONE_DEVICE to Kconfig
In-Reply-To: <20170628013236.413-1-oohall@gmail.com>
References: <20170628013236.413-1-oohall@gmail.com>
Date: Wed, 28 Jun 2017 23:08:17 +1000
Message-ID: <87r2y4b6pq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oliver O'Halloran <oohall@gmail.com> writes:

> Currently ZONE_DEVICE depends on X86_64 and this will get unwieldly as
> new architectures (and platforms) get ZONE_DEVICE support. Move to an
> arch selected Kconfig option to save us the trouble.
>
> Cc: linux-mm@kvack.org
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> Andew, the rest of the series should be going in via the ppc tree, but
> since there's nothing ppc specific about this patch do you want to
> take it via mm?

Except without this patch none of the rest of the series can be tested
on powerpc, because the code doesn't go live until ARCH_HAS_ZONE_DEVICE
is wired up for powerpc.

So it'd be better if the series stayed together, wherever it goes. I'll
pick it up unless Andrew objects.

cheers
