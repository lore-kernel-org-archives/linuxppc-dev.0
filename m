Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwfDw4QgszDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 00:22:56 +1000 (AEST)
In-Reply-To: <1461678549-12330-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: andrew.donnellan@au1.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: Re: [v2,1/6] powerpc: rework sparse for lib/xor_vmx.c
Message-Id: <3qwfDw36fbz9t3r@ozlabs.org>
Date: Fri, 29 Apr 2016 00:22:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-26-04 at 13:49:09 UTC, Daniel Axtens wrote:
> Sparse doesn't seem to be passing -maltivec around properly, leading
> to lots of errors:
...
> Only include the altivec.h header for non-__CHECKER__ builds.
> For builds with __CHECKER__, make up some stubs instead, as
> suggested by Balbir. (The vector size of 16 is arbitrary.)
> 
> Suggested-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Tested-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8fe088850f13eabf8197df5b0b

cheers
