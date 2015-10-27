Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B2EE1A0410
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 13:33:47 +1100 (AEDT)
In-Reply-To: <1445854536-22645-1-git-send-email-boqun.feng@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [RESEND, tip/locking/core, v5,
 1/6] powerpc: atomic: Make _return atomics and *{cmp}xchg fully
 ordered
Message-Id: <20151027023347.6178D140E31@ozlabs.org>
Date: Tue, 27 Oct 2015 13:33:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-26-10 at 10:15:36 UTC, Boqun Feng wrote:
> This patch fixes two problems to make value-returning atomics and
> {cmp}xchg fully ordered on PPC.

Hi Boqun,

Can you please split this into two patches. One that does the cmpxchg change
and one that changes PPC_ATOMIC_ENTRY_BARRIER.

Also given how pervasive this change is I'd like to take it via the powerpc
next tree, so can you please send this patch (which will be two after you split
it) as powerpc patches. And the rest can go via tip?

cheers
