Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjCc84PN1zDqq0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 22:46:00 +1100 (AEDT)
In-Reply-To: <20170310023351.973-1-Larry.Finger@lwfinger.net>
To: Larry Finger <Larry.Finger@lwfinger.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "regressions @ leemhuis . info" <regressions@leemhuis.info>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: powerpc: Fix crash introduced with commit 5657933dbb6e
Message-Id: <3vjCc82PtWz9s2G@ozlabs.org>
Date: Tue, 14 Mar 2017 22:46:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-10 at 02:33:51 UTC, Larry Finger wrote:
> Code inserted during the code merged between kernels 4.10 and 4.11-rc1
> caused an early panic quickly followed by a complete shutdown for
> PowerPC. The traceback was not displayed long enough to read or
> photograph, thus it is not reproduced here.
> 
> The problem was bisected to commit 5657933dbb6e ("treewide: Move dma_ops
> from struct dev_archdata into struct device"). The problem was a missing
> copy of critical information from struct dev_archdata into struct device,
> leading to the dereference of a null pointer.
> 
> This fix was suggested by Benjamin Herrenschmidt.
> 
> Fixes: commit 5657933dbb6e ("treewide: Move dma_ops from struct dev_archdata into struct device")
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: regressions@leemhuis.info <regressions@leemhuis.info>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/46f401c4297a2232a037ad8801b6c8

cheers
