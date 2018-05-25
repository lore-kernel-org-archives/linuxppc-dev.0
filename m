Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sTvN3wPjzF1Rm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 11:59:12 +1000 (AEST)
In-Reply-To: <20180509022022.21226-6-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,
 5/9] powerpc/mm/radix: implement LPID based TLB flushes to be used by
 KVM
Message-Id: <40sTvN1zzQz9s1d@ozlabs.org>
Date: Fri, 25 May 2018 11:59:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-09 at 02:20:18 UTC, Nicholas Piggin wrote:
> Implement a local TLB flush for invalidating an LPID with variants for
> process or partition scope. And a global TLB flush for invalidating
> a partition scoped page of an LPID.
> 
> These will be used by KVM in subsequent patches.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/0078778a86b14f85bf50e96d9ddeb3

cheers
