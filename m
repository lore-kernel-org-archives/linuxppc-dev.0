Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wR7pv1Z7fzDqLK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 15:06:47 +1000 (AEST)
In-Reply-To: <20170508085016.32601-1-horia.geanta@nxp.com>
To: =?utf-8?q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Mircea Pop <mircea.pop@nxp.com>
Subject: Re: powerpc: fix distclean with Makefile.postlink
Message-Id: <3wR7ps4vtfz9s75@ozlabs.org>
Date: Mon, 15 May 2017 15:06:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-08 at 08:50:16 UTC, =?utf-8?q?Horia_Geant=C4=83?= wrote:
> Makefile.postlink always includes include/config/auto.conf, however
> this file is not present in a clean kernel tree, causing make to fail:
> 
> arch/powerpc/Makefile.postlink:10: include/config/auto.conf: No such file or directory
> make[1]: *** No rule to make target `include/config/auto.conf'.  Stop.
> make: *** [vmlinuxclean] Error 2
> 
> Change the inclusion such that file not being found does not trigger
> an error.
> 
> Fixes: f188d0524d7e ("powerpc: Use the new post-link pass to check relocations")
> Reported-by: Mircea Pop <mircea.pop@nxp.com>
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/24e0bfbf63bac18495b0ad76115269

cheers
