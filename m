Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzy3tPrzDrMF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:30 +1100 (AEDT)
In-Reply-To: <1475474583-3085-1-git-send-email-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Remove static branch prediction in atomic{,
 64}_add_unless
Message-Id: <3spfzy0Nlxz9sD6@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-03-10 at 06:03:03 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> I see quite a lot of static branch mispredictions on a simple
> web serving workload. The issue is in __atomic_add_unless(), called
> from _atomic_dec_and_lock(). There is no obvious common case, so it
> is better to let the hardware predict the branch.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/61e98ebff3ba3d3b17e999dc483c26

cheers
