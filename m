Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BYl80n4KzDr2b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 16:51:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 10/14] powerpc/64: allocate pacas per node
In-Reply-To: <20180213150824.27689-11-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-11-npiggin@gmail.com>
Date: Thu, 29 Mar 2018 16:50:56 +1100
Message-ID: <87sh8j1lbz.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> Per-node allocations are possible on 64s with radix that does
> not have the bolted SLB limitation.
>
> Hash would be able to do the same if all CPUs had the bottom of
> their node-local memory bolted as well. This is left as an
> exercise for the reader.
> ---
>  arch/powerpc/kernel/paca.c     | 41 +++++++++++++++++++++++++++++++++++------
>  arch/powerpc/kernel/setup_64.c |  4 ++++
>  2 files changed, 39 insertions(+), 6 deletions(-)

Added SOB.

cheers
