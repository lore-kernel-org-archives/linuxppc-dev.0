Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWyCX6yk1zDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 21:11:04 +1100 (AEDT)
In-Reply-To: <1487313253-22846-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/powernv: Make PCI non-optional
Message-Id: <3vWyCX6Cf1z9sN9@ozlabs.org>
Date: Mon, 27 Feb 2017 21:11:04 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-17 at 06:34:13 UTC, Michael Ellerman wrote:
> Bare metal systems without PCI don't exist, so there's no real point in
> making PCI optional, it just breaks the build from time to time. In fact
> the build is broken now if you turn off PCI_MSI but enable KVM.
> 
> Using select for PCI is OK because we (powerpc) define config PCI, and it
> has no dependencies. Selecting PCI_MSI is slightly fishy, because it's
> in drivers/pci and it is user-visible, but its only dependency is PCI,
> so selecting it can't actually lead to breakage.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/a311e738b6d81febae21f0447c5b31

cheers
