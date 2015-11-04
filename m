Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 53E321A0B35
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 21:15:21 +1100 (AEDT)
Date: Wed, 4 Nov 2015 10:15:19 +0000
From: Will Deacon <will.deacon@arm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [RESEND, tip/locking/core, v5, 1/6] powerpc: atomic: Make
 _return atomics and *{cmp}xchg fully ordered
Message-ID: <20151104101518.GB5405@arm.com>
References: <1445854536-22645-1-git-send-email-boqun.feng@gmail.com>
 <20151027023347.6178D140E31@ozlabs.org>
 <20151027030652.GB26372@fixme-laptop.cn.ibm.com>
 <20151030005633.GA2792@fixme-laptop.cn.ibm.com>
 <20151102012033.GA965@fixme-laptop.cn.ibm.com>
 <20151104012213.GA11056@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151104012213.GA11056@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 04, 2015 at 09:22:13AM +0800, Boqun Feng wrote:
> Will, AFAIK, you are currently working on variants on arm64, right? I
> wonder whether you depend on patch 3 (allow archictures to provide
> self-defined __atomic_op_*), if so I can also send patch 3 as a patch
> for tip tree and wait until it merged into powerpc next to send the
> rest. 

The arm64 patches are all queued in the arm64 tree and have been sitting
in -next for a while. They don't dependent on anything else.

Will
