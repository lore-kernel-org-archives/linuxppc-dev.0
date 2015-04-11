Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0E181A086D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2015 20:39:12 +1000 (AEST)
Message-ID: <1428748751.1552.0.camel@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the powerpc-mpe tree
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sat, 11 Apr 2015 20:39:11 +1000
In-Reply-To: <20150410200240.13471ce4@canb.auug.org.au>
References: <20150410200240.13471ce4@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-10 at 20:02 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the powerpc-mpe tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> mm/gup.c: In function 'gup_pte_range':
> mm/gup.c:904:3: error: conversion to non-scalar type requested
>    pte_t pte = ACCESS_ONCE(*ptep);
>    ^
> mm/gup.c: In function '__get_user_pages_fast':
> mm/gup.c:1194:3: error: conversion to non-scalar type requested
>    pgd_t pgd = ACCESS_ONCE(*pgdp);
>    ^
> 
> Caused by commit 4bcad5b3b3ea ("powerpc: Make STRICT_MM_TYPECHECKS a
> config option").
> 
> I have reverted that commit for today.

I've dropped it from my tree for now.

You can kill me on Monday.

cheers
