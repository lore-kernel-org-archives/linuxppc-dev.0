Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8xP57hvzF2MM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:29 +1100 (AEDT)
In-Reply-To: <1521632426-30770-3-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/perf: Fix the kernel address leak to userspace via
 SDAR
Message-Id: <40B8xP0mqpz9s0b@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:28 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-21 at 11:40:26 UTC, Madhavan Srinivasan wrote:
> Sampled Data Address Register (SDAR) is a 64-bit
> register that contains the effective address of
> the storage operand of an instruction that was
> being executed, possibly out-of-order, at or around
> the time that the Performance Monitor alert occurred.
> 
> In certain scenario SDAR happen to contain the kernel
> address even for userspace only sampling. Add checks
> to prevent it.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cd1231d7035fea894118d5155ff984

cheers
