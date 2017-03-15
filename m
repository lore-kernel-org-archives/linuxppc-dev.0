Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjq6t1DdqzDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 22:26:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 4/5] powerpc/smp: add cpu_cache_mask
In-Reply-To: <20170302004920.21948-4-oohall@gmail.com>
References: <20170302004920.21948-1-oohall@gmail.com>
 <20170302004920.21948-4-oohall@gmail.com>
Date: Wed, 15 Mar 2017 22:26:12 +1100
Message-ID: <871stylr1n.fsf@concordia.ellerman.id.au>
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

> Traditionally we have only ever tracked which CPUs are in the same core
> (cpu_sibling_mask) and on the same die (cpu_core_mask). For Power9 we
> need to be aware of which CPUs share cache with each other so this patch
> adds cpu_cache_mask and the underlying cpu_cache_map variable to track
> this.

But which cache?

Some CPUs on Power8 share L3, or L4.

I think just call it cpu_l2cache_map to make it explicit.

cheers
