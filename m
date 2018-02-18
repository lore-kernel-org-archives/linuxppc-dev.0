Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zkggy3ghvzDrVp
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Feb 2018 19:55:26 +1100 (AEDT)
In-Reply-To: <20180214032706.6242-1-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Expose TSCR via sysfs only on powernv
Message-Id: <3zkggy2CJnz9sWJ@ozlabs.org>
Date: Sun, 18 Feb 2018 19:55:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-02-14 at 03:27:06 UTC, Cyril Bur wrote:
> The TSCR can only be accessed in hypervisor mode.
> 
> Fixes: 88b5e12eeb11 ("powerpc: Expose TSCR via sysfs")
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c134f0d57a47b7f8704dee1cefc246

cheers
