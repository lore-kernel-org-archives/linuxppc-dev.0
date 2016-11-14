Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzR1JHDzDvc8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:07 +1100 (AEDT)
In-Reply-To: <20161031021939.30989-2-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 Jack Miller <jack@codezen.org>
Subject: Re: [2/2] Revert "powerpc: Load Monitor Register Support"
Message-Id: <3tHTzQ74T7z9t2C@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:06 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-31-10 at 02:19:39 UTC, Michael Neuling wrote:
> Load monitored is no longer supported on POWER9 so let's remove the
> code.
> 
> This reverts commit bd3ea317fddfd0f2044f94bed294b90c4bc8e69e.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/29a969b764817c1dce819c2bc8c00a

cheers
