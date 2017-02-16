Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP58g5MrMzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:59:47 +1100 (AEDT)
In-Reply-To: <1487156077-30798-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm: Fix build break with BOOK3S_64=n and MEMORY_HOTPLUG=y
Message-Id: <3vP58g3H2nz9sD5@ozlabs.org>
Date: Thu, 16 Feb 2017 16:59:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-15 at 10:54:37 UTC, Michael Ellerman wrote:
> The recently merged HPT (Hash Page Table) resize support broke the build
> when BOOK3S_64=n (ie. 32-bit or 64-bit Book3E) and MEMORY_HOTPLUG=y:
> 
>   arch/powerpc/mm/mem.o: In function `.arch_add_memory':
>   (.text+0x4e4): undefined reference to `.resize_hpt_for_hotplug'
> 
> Fix it by adding a dummy version.
> 
> Fixes: 438cc81a41e8 ("powerpc/pseries: Automatically resize HPT for memory hot add/remove")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/36b390fd624a7f3a64bda5de54fa58

cheers
