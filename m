Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjsMY0bLTzDqR1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 14:07:37 +1000 (AEST)
In-Reply-To: <20170525072832.30803-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org
Subject: Re: [v2] powerpc/mm: convert tlbie to tlbiel when no batch is active
Message-Id: <3wjsMX6gNHz9sCX@ozlabs.org>
Date: Thu,  8 Jun 2017 14:07:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-05-25 at 07:28:32 UTC, Balbir Singh wrote:
> Do the checks that __flush_tlb_pending() does and check if
> a local flush will do when batch->active is false inside of
> hpte_need_flush(). I've checked the changes with tlbie tracing,
> I see local flushes as applicable now and I've also run
> some basic ltp testcases on top of these changes on a powernv
> machine.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c5cee6421cd651446b93c231f0ab8f

cheers
