Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBNR2wFqzDrJ6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:38:31 +1000 (AEST)
In-Reply-To: <1500983262-8040-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org
Subject: Re: [v6] powerpc/mm/radix: Workaround prefetch issue with KVM
Message-Id: <3xJBNQ6vjBz9sDB@ozlabs.org>
Date: Thu, 27 Jul 2017 22:38:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-07-25 at 11:47:42 UTC, Michael Ellerman wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> There's a somewhat architectural issue with Radix MMU and KVM.
> 
> When coming out of a guest with AIL (Alternate Interrupt Location, ie,
> MMU enabled), we start executing hypervisor code with the PID register
> still containing whatever the guest has been using.
...
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> [mpe: Rework the asm to build with CONFIG_PPC_RADIX_MMU=n, drop
>       unneeded include of kvm_book3s_asm.h]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/a25bd72badfa793ab5aeafd50dbd9d

cheers
