Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8Mh73xyZzDqLB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 14:09:43 +1000 (AEST)
In-Reply-To: <20170413094548.10616-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: Use relon prolog for EXC_VIRT_OOL_MASKABLE_HV
 handlers
Message-Id: <3w8Mh73PlNz9s73@ozlabs.org>
Date: Fri, 21 Apr 2017 14:09:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-13 at 09:45:48 UTC, Nicholas Piggin wrote:
> Hypervisor Virtualization and Directed Hypervisor Doorbell interrupt
> handlers use the macro EXC_VIRT_OOL_MASKABLE_HV for their relocation-on
> handlers, which calls MASKABLE_RELON_EXCEPTION_HV_OOL, which uses the
> real mode interrupt prolog.
> 
> Use the RELON variant instead to reduce overhead.
> 
> Fixes: 1707dd1613 ("powerpc: Save CFAR before branching in interrupt entry paths")
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a050d20d024dc3e1b988e715e2d811

cheers
