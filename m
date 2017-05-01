Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGTdk2QjLzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:58:50 +1000 (AEST)
In-Reply-To: <20161126032612.13559-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/4] powerpc: use the new post-link pass to check relocations
Message-Id: <3wGTdk1gTfz9sDF@ozlabs.org>
Date: Mon,  1 May 2017 12:58:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-11-26 at 03:26:09 UTC, Nicholas Piggin wrote:
> Currently powerpc has to introduce a dependency on its default
> build target zImage in order to run a relocation check pass
> over the linked vmlinux. This is deficient because the check
> is not run if the plain vmlinux target is built, or if one of
> the other boot targets is built.
> 
> Switch to using the kbuild post-link pass in order to run this
> check. In future powerpc will use this to do more complicated
> operations, but initially using it for something simple is a
> good first step.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f188d0524d7e09f7ec801df9761dc1

cheers
