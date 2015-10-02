Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A1C51A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 17:47:11 +1000 (AEST)
In-Reply-To: <1438916742-31924-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org,
 Anton Blanchard <anton@samba.org>
Subject: Re: powerpc/vdso: Emit GNU & SysV hashes
Message-Id: <20151002074710.5E434140B0E@ozlabs.org>
Date: Fri,  2 Oct 2015 17:47:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-08 at 03:05:42 UTC, Michael Ellerman wrote:
> Andy Lutomirski says:
> 
>   Some dynamic loaders may be slightly faster if a GNU hash is
>   available.
> 
>   This is unlikely to have any measurable effect on the time it takes
>   to resolve vdso symbols (since there are so few of them).  In some
>   contexts, it can be a win for a different reason: if every DSO has a
>   GNU hash section, then libc can avoid calculating SysV hashes at
>   all. Both musl and glibc appear to have this optimization.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/787b393c9f6300c343600d39

cheers
