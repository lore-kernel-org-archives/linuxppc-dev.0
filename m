Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3mJR1NsQzDt1s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 21:21:11 +1100 (AEDT)
In-Reply-To: <1476935832-28880-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org
Subject: Re: KVM: PPC: Book3S HV: Fix build error when SMP=n
Message-Id: <3t3mJQ5zZXz9sf9@ozlabs.org>
Date: Wed, 26 Oct 2016 21:21:10 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-20-10 at 03:57:12 UTC, Michael Ellerman wrote:
> Commit 5d375199ea96 ("KVM: PPC: Book3S HV: Set server for passed-through
> interrupts") broke the SMP=n build:
> 
>   arch/powerpc/kvm/book3s_hv_rm_xics.c:758:2: error: implicit declaration of function 'get_hard_smp_processor_id'
> 
> That is because we lost the implicit include of asm/smp.h, so include it
> explicitly to get the definition for get_hard_smp_processor_id().
> 
> Fixes: 5d375199ea96 ("KVM: PPC: Book3S HV: Set server for passed-through interrupts")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/62623d5f918fb1c8ed86b03b9a86cc

cheers
