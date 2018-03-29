Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BYlH4qMfzF0WV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 16:51:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 09/14] powerpc/64: defer paca allocation until memory
 topology is discovered
In-Reply-To: <20180213150824.27689-10-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
 <20180213150824.27689-10-npiggin@gmail.com>
Date: Thu, 29 Mar 2018 16:51:07 +1100
Message-ID: <87po3n1lbo.fsf@concordia.ellerman.id.au>
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
> ---
>  arch/powerpc/include/asm/paca.h    |  3 +-
>  arch/powerpc/kernel/paca.c         | 90 ++++++++++++--------------------------
>  arch/powerpc/kernel/prom.c         |  5 ++-
>  arch/powerpc/kernel/setup-common.c | 24 +++++++---
>  4 files changed, 51 insertions(+), 71 deletions(-)

Added SOB.

cheers
