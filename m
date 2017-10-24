Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLmB00cSSzDqmf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:08:40 +1100 (AEDT)
In-Reply-To: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, mikey@neuling.org, cyrilbur@gmail.com
Subject: Re: [1/4] powerpc/tm: Add commandline option to disable hardware
 transactional memory
Message-Id: <3yLm9z681Xz9s9Y@ozlabs.org>
Date: Tue, 24 Oct 2017 19:08:39 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-12 at 10:17:16 UTC, Michael Ellerman wrote:
> From: Cyril Bur <cyrilbur@gmail.com>
> 
> Currently the kernel relies on firmware to inform it whether or not the
> CPU supports HTM and as long as the kernel was built with
> CONFIG_PPC_TRANSACTIONAL_MEM=y then it will allow userspace to make
> use of the facility.
> 
> There may be situations where it would be advantageous for the kernel
> to not allow userspace to use HTM, currently the only way to achieve
> this is to recompile the kernel with CONFIG_PPC_TRANSACTIONAL_MEM=n.
> 
> This patch adds a simple commandline option so that HTM can be
> disabled at boot time.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> [mpe: Simplify to a bool, move to prom.c, put doco in the right place.
>  Always disable, regardless of initial state, to avoid user confusion.]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/07fd1761e1cd2b5ecdb470fc228d52

cheers
