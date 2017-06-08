Return-Path: <srs0=sx90=5n=infradead.org=peterz@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk6Dr0QL8zDqM3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 23:47:40 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wk6Dq672qz8t4Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 23:47:39 +1000 (AEST)
Date: Thu, 8 Jun 2017 15:47:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, torvalds@linux-foundation.org,
 will.deacon@arm.com, oleg@redhat.com, paulmck@linux.vnet.ibm.com,
 benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 mingo@kernel.org, stern@rowland.harvard.edu,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH 5/5] powerpc: Remove SYNC from _switch
Message-ID: <20170608134729.4rwykawnrijtr2yh@hirez.programming.kicks-ass.net>
References: <20170607161501.819948352@infradead.org>
 <20170607162013.905320602@infradead.org>
 <20170608103244.1b4b24c9@roar.ozlabs.ibm.com>
 <20170608065400.zhfao5lba6i3s7j6@hirez.programming.kicks-ass.net>
 <20170608172938.62b30475@roar.ozlabs.ibm.com>
 <20170608075720.kc2p3tybghzbmrz3@hirez.programming.kicks-ass.net>
 <877f0mere1.fsf@concordia.ellerman.id.au>
 <20170608200015.7f92965a@roar.ozlabs.ibm.com>
 <20170608124540.olt2rv3nbnd45pxr@hirez.programming.kicks-ass.net>
 <20170608231813.7fdac022@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170608231813.7fdac022@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 08, 2017 at 11:18:13PM +1000, Nicholas Piggin wrote:
> I guess I see your point... okay, will constrain the comment to powerpc
> context switch and primitives code. Any fundamental change to such
> scheduler barriers I guess would require at least a glance over arch
> switch code :)

Just so.

> My plan is to send the powerpc sync removal patch for hopefully 4.13
> merge. I'm pretty sure it will be equally happy with your patches.
> Unless you can see any problems with it? More eyes would be welcome.

Feel free to Cc me. I don't see a problem with removing that SYNC now,
I'll rebase my patches on top.
