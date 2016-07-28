Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0GKz3MVszDrKN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 12:40:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Marek <mmarek@suse.cz>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
In-Reply-To: <20160728120814.59e42bc8@canb.auug.org.au>
References: <20160728120814.59e42bc8@canb.auug.org.au>
Date: Thu, 28 Jul 2016 12:40:04 +1000
Message-ID: <8737mutri3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Michal,
>
> After merging the kbuild tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
...
> arch/powerpc/mm/hash_utils_64.c:929:10: note: in expansion of macro 'IS_ENABLED'
>   else if IS_ENABLED(CONFIG_PPC_NATIVE)
>           ^
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   7353644fa9df ("powerpc/mm: Fix build break when PPC_NATIVE=n")
>
> from the powerpc tree interacting with commit
>
>   5e8754fd80b0 ("kconfig.h: allow to use IS_{ENABLE,REACHABLE} in macro expansion")
>
> from the kbuild tree.

**expletive deleted**

I was wary of IS_ENABLED(), I should have trusted my instincts.

> I have applied the following fix patch (that should be applied to the
> powerpc tree):

Applied, thanks.

cheers
