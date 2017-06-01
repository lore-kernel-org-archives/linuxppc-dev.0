Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdpBy6lx8zDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 23:31:06 +1000 (AEST)
In-Reply-To: <20170511112441.30287-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: dt_cpu_ftrs boot time setup option
Message-Id: <3wdpBy5jbbz9s8J@ozlabs.org>
Date: Thu,  1 Jun 2017 23:31:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-05-11 at 11:24:41 UTC, Nicholas Piggin wrote:
> Provide a dt_cpu_ftrs= cmdline option to disable the dt_cpu_ftrs CPU
> feature discovery, and fall back to the "cputable" based version.
> 
> Also allow control of advertising unknown features to userspace and
> with this parameter, and remove the clunky CONFIG option.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a2b05b7aa60e1e9b60faf01dfb1cca

cheers
