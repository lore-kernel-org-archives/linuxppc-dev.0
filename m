Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BACD81A039D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 03:17:26 +1000 (AEST)
Date: Thu, 1 Oct 2015 19:11:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 5/7] powerpc: atomic: Implement cmpxchg{,64}_* and
 atomic{,64}_cmpxchg_* variants
Message-ID: <20151001171151.GW3816@twins.programming.kicks-ass.net>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-6-git-send-email-boqun.feng@gmail.com>
 <20151001122715.GQ2881@worktop.programming.kicks-ass.net>
 <20151001123626.GB3281@worktop.programming.kicks-ass.net>
 <20151001151219.GD4043@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151001151219.GD4043@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 01, 2015 at 08:12:19AM -0700, Paul E. McKenney wrote:

> What C11 does is to allow the developer to specify different orderings
> on success and failure.  But it is no harder to supply a barrier (if
> needed) on the failure path, right?

Quite right.
