Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwd2v6XrszDrnh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 00:31:19 +1100 (AEDT)
In-Reply-To: <20180301010249.GA18370@beast>
To: Kees Cook <keescook@chromium.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Keep const vars out of writable .sdata
Message-Id: <3zwd2v0v8nz9shN@ozlabs.org>
Date: Wed,  7 Mar 2018 00:31:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-01 at 01:02:49 UTC, Kees Cook wrote:
> From: Segher Boessenkool <segher@kernel.crashing.org>
> 
> Newer gcc will support "-mno-readonly-in-sdata"[1], which makes sure that
> the optimization on PPC32 for variables getting moved into the .sdata
> section will not apply to const variables (which must be in .rodata).
> 
> This was originally noticed in mm/rodata_test.c when rodata_test_data
> was not static:
> 
> c0695034 g     O .data	00000004 rodata_test_data
> 
> After this patch with an updated compiler, this is correctly in .rodata.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82411
> 
> Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/51d42f0f5fd6c74144d19bf6a66352

cheers
