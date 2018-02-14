Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zh7cf0P09zF12y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:43:46 +1100 (AEDT)
In-Reply-To: <20180201050944.30332-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [kernel,
 v2] powerpc/mm: Flush radix process translations when setting MMU type
Message-Id: <3zh7cd6WzLz9t3C@ozlabs.org>
Date: Wed, 14 Feb 2018 16:43:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-02-01 at 05:09:44 UTC, Alexey Kardashevskiy wrote:
> Radix guests do normally invalidate process-scoped translations when
> a new pid is allocated but migrated guests do not invalidate these so
> migrated guests crash sometime, especially easy to reproduce with
> migration happening within first 10 seconds after the guest boot start on
> the same machine.
> 
> This adds the "Invalidate process-scoped translations" flush to fix
> radix guests migration.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Tested-by: Laurent Vivier <lvivier@redhat.com>
> Tested-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/62e984ddfd6b056d399e24113f5e6a

cheers
