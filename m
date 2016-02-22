Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 020DD1A0743
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 20:45:56 +1100 (AEDT)
In-Reply-To: <1450189457-10589-2-git-send-email-boqun.feng@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [v6,
 1/4] atomics: Allow architectures to define their own __atomic_op_*
 helpers
Message-Id: <20160222094555.CF1D7140C30@ozlabs.org>
Date: Mon, 22 Feb 2016 20:45:55 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-15-12 at 14:24:14 UTC, Boqun Feng wrote:
> Some architectures may have their special barriers for acquire, release
> and fence semantics, so that general memory barriers(smp_mb__*_atomic())
> in the default __atomic_op_*() may be too strong, so allow architectures
> to define their own helpers which can overwrite the default helpers.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e1ab7f39d7e0dbfbdefe148be3

cheers
