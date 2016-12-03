Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW80F40pGzDw1s
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:28:13 +1100 (AEDT)
In-Reply-To: <1480585846-7936-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2,1/2] powerpc/cell: Drop select of MEMORY_HOTPLUG
Message-Id: <3tW80F2G3qz9t1F@ozlabs.org>
Date: Sat,  3 Dec 2016 22:28:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-01 at 09:50:45 UTC, Michael Ellerman wrote:
> SPU_FS selects MEMORY_HOTPLUG, which is problematic because
> MEMORY_HOTPLUG is user selectable, meaning we can end up with a broken
> .config where MEMORY_HOTPLUG is enabled but its dependencies are not,
> leading to build breakages.
> 
> The select of MEMORY_HOTPLUG for SPU_FS was added back in 2006, in
> commit 4da30d15b6d5 ("[POWERPC] spufs: fix memory hotplug dependency").
> 
> However we reworked the spufs code and removed the dependency on memory
> hotplug in 2007 in commit 78bde53e351b ("[POWERPC] spufs: remove need
> for struct page for SPEs").
> 
> So drop the select as it's no longer needed and causes problems.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/577ec789a79eb34f85a26c01f38516

cheers
