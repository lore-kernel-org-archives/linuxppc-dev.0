Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0Y0F38HszDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 08:40:29 +1000 (AEST)
In-Reply-To: <1460439238-13428-1-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Remove unused remnants from A2 cpu
Message-Id: <3r0Y0F1bXDz9t3v@ozlabs.org>
Date: Thu,  5 May 2016 08:40:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-04 at 05:33:58 UTC, Rashmica Gupta wrote:
> Support for the A2 cpu was removed in commit fb5a515704d7 ("powerpc:
> Remove platforms/wsp and associated pieces"), and the externs:
> __setup_cpu_a2 and __restore_cpu_a2 are still around and unused, so
> remove them.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bdcc37e7b27a485abde41b9e5b

cheers
