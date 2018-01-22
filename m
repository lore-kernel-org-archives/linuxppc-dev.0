Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqw5nZwzF0XT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:20 +1100 (AEDT)
In-Reply-To: <20171223151550.30612-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v3] powerpc/64s: Improve local TLB flush for boot and MCE on
 POWER9
Message-Id: <3zPxqv0lG7z9sBW@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-12-23 at 15:15:50 UTC, Nicholas Piggin wrote:
> There are several cases outside the normal address space management
> where a CPU's entire local TLB is to be flushed:
> 
>   1. Booting the kernel, in case something has left stale entries in
>      the TLB (e.g., kexec).
> 
>   2. Machine check, to clean corrupted TLB entries.
...
> 
> The TLB flush is no longer called when restoring from deep idle states.
> This was not be done as a separate step because booting secondaries
> uses the same cpu_restore as idle restore, which needs the TLB flush.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d4748276ae14ce951a3254852dddc3

cheers
