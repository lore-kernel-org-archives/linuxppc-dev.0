Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV5g523jyzDqmM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 22:39:13 +1000 (AEST)
In-Reply-To: <1464523432-12605-2-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, acsawdey@linux.vnet.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [2/3] powerpc: Avoid load hit store in setup_sigcontext()
Message-Id: <3rV5g512vHz9t1V@ozlabs.org>
Date: Wed, 15 Jun 2016 22:39:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-29-05 at 12:03:51 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> In setup_sigcontext(), we set current->thread.vrsave then use it
> straight after. Since current is hidden from the compiler via inline
> assembly, it cannot optimise this and we end up with a load hit store.
> 
> Fix this by using a temporary.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d96f234f47aff593538f9e3d67

cheers
