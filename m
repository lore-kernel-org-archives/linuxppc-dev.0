Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPx5471B3zDvxP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 10:59:20 +1100 (AEDT)
In-Reply-To: <20161122035222.27115-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc: add more asm-prototypes.h declarations for asm exports
Message-Id: <3tPx5415Hxz9t0Z@ozlabs.org>
Date: Fri, 25 Nov 2016 10:59:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-22 at 03:52:22 UTC, Nicholas Piggin wrote:
> After patch 4efca4ed0 ("kbuild: modversions for EXPORT_SYMBOL() for asm"),
> asm exports can get modversions CRCs generated if they have C definitions
> in asm-prototypes.h. This patch adds missing definitions for 32 and 64 bit
> allmodconfig builds.
> 
> Fixes: 9445aa1a3062 ("ppc: move exports to definitions")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9e5f68842276672a05737c23e40725

cheers
