Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxSc10t5tzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 20:13:21 +1000 (AEST)
In-Reply-To: <148969794004.4130.14805754334064000704.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2,
 1/2] powerpc/fadump: reserve memory at an offset closer to bottom of
 RAM
Message-Id: <3vxSc029vlz9s86@ozlabs.org>
Date: Mon,  3 Apr 2017 20:13:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-03-16 at 21:05:26 UTC, Hari Bathini wrote:
> Currently, the area to preserve boot memory is reserved at the top of
> RAM. This leaves fadump vulnerable to memory hot-remove operations. As
> memory for fadump has to be reserved early in the boot process, fadump
> can't be registered after a memory hot-remove operation. Though this
> problem can't be eleminated completely, the impact can be minimized by
> reserving memory at an offset closer to bottom of the RAM. The offset
> for fadump memory reservation can be any value greater than fadump boot
> memory size.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f6e6bedb773118713a8eb3736a4c99

cheers
