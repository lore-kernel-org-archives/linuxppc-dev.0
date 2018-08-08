Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltx76tDpzDqk8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:26:35 +1000 (AEST)
In-Reply-To: <20180731120842.32715-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, andrew.donnellan@au1.ibm.com
Subject: Re: [v2,
 1/2] selftests/powerpc: Skip earlier in alignment_handler test
Message-Id: <41ltx45GNVz9s4Z@ozlabs.org>
Date: Thu,  9 Aug 2018 00:26:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-07-31 at 12:08:41 UTC, Michael Ellerman wrote:
> Currently the alignment_handler test prints "Can't open /dev/fb0"
> about 80 times per run, which is a little annoying.
> 
> Refactor it to check earlier if it can open /dev/fb0 and skip if not,
> this results in each test printing something like:
> 
>   test: test_alignment_handler_vsx_206
>   tags: git_version:v4.18-rc3-134-gfb21a48904aa
>   [SKIP] Test skipped on line 291
>   skip: test_alignment_handler_vsx_206
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/edba42cd14dbb0cc8b48cf786b006a

cheers
