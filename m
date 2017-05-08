Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wM1GS5lyWzDqFx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 May 2017 21:57:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Mircea Pop <mircea.pop@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: fix distclean with Makefile.postlink
In-Reply-To: <20170508085016.32601-1-horia.geanta@nxp.com>
References: <20170508085016.32601-1-horia.geanta@nxp.com>
Date: Mon, 08 May 2017 21:57:48 +1000
Message-ID: <8737cf8ssj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Horia Geant=C4=83 <horia.geanta@nxp.com> writes:

> Makefile.postlink always includes include/config/auto.conf, however
> this file is not present in a clean kernel tree, causing make to fail:
>
> arch/powerpc/Makefile.postlink:10: include/config/auto.conf: No such file=
 or directory
> make[1]: *** No rule to make target `include/config/auto.conf'.  Stop.
> make: *** [vmlinuxclean] Error 2
>
> Change the inclusion such that file not being found does not trigger
> an error.
>
> Fixes: f188d0524d7e ("powerpc: Use the new post-link pass to check reloca=
tions")

I can't reproduce this. What exact steps are you doing? And what version
of Make?

cheers
