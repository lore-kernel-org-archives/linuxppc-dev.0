Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW3Z4YDgzDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:36:10 +1100 (AEDT)
In-Reply-To: <1486376008-2841-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/2] selftests/powerpc: Refactor the AUXV routines
Message-Id: <3vnW3Z3Tcnz9s82@ozlabs.org>
Date: Tue, 21 Mar 2017 22:36:10 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-06 at 10:13:27 UTC, Michael Ellerman wrote:
> Refactor the AUXV routines so they are more composable. In a future test
> we want to look for many AUXV entries and we don't want to have to read
> /proc/self/auxv each time.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/e3028437cb45c04a9caae4d6372bfe

cheers
