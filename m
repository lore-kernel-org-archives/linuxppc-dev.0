Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTv90l7rzDqyp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:25 +1000 (AEST)
In-Reply-To: <1467695057-12431-11-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [10/41] powerpc: Add comment explaining the purpose of
 setup_kdump_trampoline()
Message-Id: <3rrTv84gcTz9sCZ@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 05:03:46 UTC, Benjamin Herrenschmidt wrote:
> Anything in early_setup() needs to be justified to be there, in
> this case, we need the trampolines before we can take exceptions
> and thus before we turn on the MMU.
> 
> Also remove a pretty meaningless and misplaced debug message
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/63c254a501049f70c53aea6025

cheers
