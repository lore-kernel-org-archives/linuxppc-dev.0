Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlLV53rnHzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 21:02:05 +1000 (AEST)
Message-ID: <1460545318.24090.1.camel@ellerman.id.au>
Subject: Re: [PATCH] sched/cpuacct: Check for NULL when using task_pt_regs()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ingo Molnar <mingo@kernel.org>, Srikar Dronamraju
 <srikar@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, Peter Zijlstra
 <peterz@infradead.org>,  tglx@linutronix.de, efault@gmx.de,
 htejun@gmail.com, linux-kernel@vger.kernel.org,  tj@kernel.org,
 torvalds@linux-foundation.org, zhaolei@cn.fujitsu.com,
 yangds.fnst@cn.fujitsu.com, hpa@zytor.com, Stephen Rothwell
 <sfr@canb.auug.org.au>,  linuxppc-dev@lists.ozlabs.org
Date: Wed, 13 Apr 2016 21:01:58 +1000
In-Reply-To: <20160413074319.GA8968@gmail.com>
References: <aa171da036b520b51c79549e9b3215d29473f19d.1458635566.git.zhaolei@cn.fujitsu.com>
 <tip-d740037fac7052e49450f6fa1454f1144a103b55@git.kernel.org>
 <20160404140312.GA28495@linux.vnet.ibm.com>
 <20160406065436.GB3078@gmail.com> <20160406203219.788ae7cf@kryten>
 <20160406110803.GI2906@worktop> <20160406215950.04bc3f0b@kryten>
 <20160406132637.GA2108@linux.vnet.ibm.com>
 <20160413074319.GA8968@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-13 at 09:43 +0200, Ingo Molnar wrote:
> * Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:
> 
> > * Anton Blanchard <anton@samba.org> [2016-04-06 21:59:50]:
> > 
> > > Looks good, and the patch below does fix the oops for me.
> > > 
> > > Anton
> > > --
> > > 
> > > task_pt_regs() can return NULL for kernel threads, so add a check.
> > > This fixes an oops at boot on ppc64.
> > > 
> > > Signed-off-by: Anton Blanchard <anton@samba.org>
> > 
> > Works for me too.
> > 
> > Reported-and-Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> 
> Could someone please re-send the fix, because it has not reached me nor lkml.

It did hit LKML:

http://lkml.kernel.org/r/20160406215950.04bc3f0b@kryten

But that did have some verbiage at the top.

Anton's also resent it directly To you.

cheers
