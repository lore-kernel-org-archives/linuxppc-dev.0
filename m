Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptdM0K89zF0WK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:18 +1000 (AEST)
In-Reply-To: <da0c182b76c27988b88ebd35ee284f5be5882dd1.1533802042.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/lib: Use patch_site to patch copy_32 functions once cache
 is enabled
Message-Id: <41ptdK3GPNz9sCq@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-09 at 08:14:41 UTC, Christophe Leroy wrote:
> The symbol memcpy_nocache_branch defined in order to allow patching
> of memset function once cache is enabled leads to confusing reports
> by perf tool.
> 
> Using the new patch_site functionality solves this issue.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fa54a981ea7a852c145b05c95abba1

cheers
