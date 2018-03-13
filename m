Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400vFH2mMLzDrBW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 23:25:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 07/14] powerpc/64: move default SPR recording
In-Reply-To: <20180213150824.27689-8-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-8-npiggin@gmail.com>
Date: Tue, 13 Mar 2018 23:25:05 +1100
Message-ID: <87zi3cf9i6.fsf@concordia.ellerman.id.au>
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

> Move this into the early setup code, and don't iterate over CPU masks.
> We don't want to call into sysfs so early from setup, and a future patch
> won't initialize CPU masks by the time this is called.
> ---
>  arch/powerpc/kernel/paca.c     |  3 +++
>  arch/powerpc/kernel/setup.h    |  9 +++------
>  arch/powerpc/kernel/setup_64.c |  8 ++++++++
>  arch/powerpc/kernel/sysfs.c    | 18 +++++++-----------
>  4 files changed, 21 insertions(+), 17 deletions(-)

This patch, and 8, 9, 10, aren't signed-off by you.

I'll assume you just forgot and add it.

cheers
