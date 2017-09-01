Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkKqC2K7wzDqhM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 23:29:59 +1000 (AEST)
In-Reply-To: <1503571797-16885-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, anton@samba.org
Subject: Re: powerpc: Fix DAR reporting when alignment handler faults
Message-Id: <3xkKqB2kL5z9t2x@ozlabs.org>
Date: Fri,  1 Sep 2017 23:29:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-24 at 10:49:57 UTC, Michael Ellerman wrote:
> Anton noticed that if we fault part way through emulating an unaligned
> instruction, we don't update the DAR to reflect that.
> 
> The DAR value is eventually reported back to userspace as the address
> in the SEGV signal, and if userspace is using that value to demand
> fault then it can be confused by us not setting the value correctly.
> 
> This patch is ugly as hell, but is intended to be the minimal fix and
> back ports easily.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/f9effe925039cf54489b5c04e0d400

cheers
