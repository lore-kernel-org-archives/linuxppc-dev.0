Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKKXr0697zDvs7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 23:03:56 +1100 (AEDT)
In-Reply-To: <1464328140-31178-1-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3,1/2] powerpc/mm: Dump linux pagetables
Message-Id: <3tKKXq67gcz9t1T@ozlabs.org>
Date: Thu, 17 Nov 2016 23:03:55 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-27-05 at 05:48:59 UTC, Rashmica Gupta wrote:
> Useful to be able to dump the kernels page tables to check permissions
> and memory types - derived from arm64's implementation.
> 
> Add a debugfs file to check the page tables. To use this the PPC_PTDUMP
> config option must be selected.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8eb07b187000d48152c4ef97f075bd

cheers
