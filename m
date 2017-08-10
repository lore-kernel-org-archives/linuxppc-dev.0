Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSpWq1k2FzDqs4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 23:14:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 10/13] powerpc/64s: idle simplify KVM idle on POWER9
In-Reply-To: <20170805170241.22966-11-npiggin@gmail.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-11-npiggin@gmail.com>
Date: Thu, 10 Aug 2017 23:14:46 +1000
Message-ID: <87zib7lg3d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> POWER9 CPUs have independent MMU contexts per thread so KVM
> does not have to bring sibling threads into real-mode when
> switching MMU mode to guest. This can simplify POWER9 sleep/wake
> paths and avoids hwsyncs.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/kvm_book3s_asm.h |  4 ++++
>  arch/powerpc/kernel/idle_book3s.S         |  8 ++-----
>  arch/powerpc/kvm/book3s_hv.c              | 37 ++++++++++++++++++++++++++-----
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  8 +++++++

This will need to go via, or at least be shared with Paul's tree.

So if it's possible, splitting it out of this series would be easier.

cheers
