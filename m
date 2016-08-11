Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s957f21lvzDqh7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 21:16:46 +1000 (AEST)
In-Reply-To: <1470648943-15643-1-git-send-email-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc: rebuild vdsos correctly
Message-Id: <3s957f0gHyz9t1P@ozlabs.org>
Date: Thu, 11 Aug 2016 21:16:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-08-08 at 09:35:43 UTC, Nicholas Piggin wrote:
> When using if_changed, we need to add FORCE to dependencies, otherwise
> we don't get command line change checking amongst other things. This
> has resulted in vdsos not being rebuilt when switching between big and
> little endian.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b9a4a0d02c5b8d9a1397c11d74

cheers
