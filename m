Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTvX06f9zDqyj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:44 +1000 (AEST)
In-Reply-To: <1468210651-4199-1-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: sjitindarsingh@gmail.com
Subject: Re: powerpc/crash: Rearrange loop condition to avoid out of bounds
 array access
Message-Id: <3rrTvW3rVDz9sCZ@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-07 at 04:17:31 UTC, Suraj Jitindar Singh wrote:
> The array crash_shutdown_handles[] has size CRASH_HANDLER_MAX, thus when
> we loop over the elements of the list we check crash_shutdown_handles[i]
> && i < CRASH_HANDLER_MAX. However this means that when we increment i to
> CRASH_HANDLER_MAX we will perform an out of bound array access checking
> the first condition before exiting on the second condition.
> 
> To avoid the out of bounds access, simply reorder the loop conditions.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a7d6392866e9777cb287ad194c

cheers
