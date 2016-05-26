Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFwGt0Q3rzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 02:54:30 +1000 (AEST)
Date: Thu, 26 May 2016 18:54:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com,
 paulmck@linux.vnet.ibm.com, jeremy@goop.org, chrisw@sous-sol.org,
 akataria@vmware.com, rusty@rustcorp.com.au
Subject: Re: [PATCH v3 0/6] powerpc use pv-qpsinlock as the default spinlock
 implemention
Message-ID: <20160526165423.GN3206@twins.programming.kicks-ass.net>
References: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 25, 2016 at 04:18:03PM +0800, Pan Xinhui wrote:
> I do several tests on pseries IBM,8408-E8E with 32cpus, 64GB memory.
> benchmark test results are below.

> _____test________________spinlcok______________pv-qspinlcok_____
> | compiling takes|	22m 		|	22m		|

How can a kernel build take 22 minutes with 32 CPUs? That's far too
long. My 40 CPU IVB-EP takes all of 50 seconds to build an
x86_64-defconfig from scratch.
