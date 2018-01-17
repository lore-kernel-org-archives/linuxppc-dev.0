Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7Bx1KKTzF0bG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:26:01 +1100 (AEDT)
In-Reply-To: <20180116112431.1737-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/64s: Allow control of RFI flush via debugfs
Message-Id: <3zM7Bw1sbmz9sPk@ozlabs.org>
Date: Thu, 18 Jan 2018 00:25:59 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-01-16 at 11:24:31 UTC, Michael Ellerman wrote:
> Expose the state of the RFI flush (enabled/disabled) via debugfs, and
> allow it to be enabled/disabled at runtime.
> 
> eg: $ cat /sys/kernel/debug/powerpc/rfi_flush
>     1
>     $ echo 0 > /sys/kernel/debug/powerpc/rfi_flush
>     $ cat /sys/kernel/debug/powerpc/rfi_flush
>     0
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/236003e6b5443c45c18e613d2b0d77

cheers
