Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlG4v2kzFzDqBg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 17:43:27 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id y144so11404286wmd.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 00:43:27 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 13 Apr 2016 09:43:19 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>,
 Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
 efault@gmx.de, htejun@gmail.com, linux-kernel@vger.kernel.org,
 tj@kernel.org, torvalds@linux-foundation.org,
 zhaolei@cn.fujitsu.com, yangds.fnst@cn.fujitsu.com, hpa@zytor.com,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] sched/cpuacct: Check for NULL when using task_pt_regs()
Message-ID: <20160413074319.GA8968@gmail.com>
References: <aa171da036b520b51c79549e9b3215d29473f19d.1458635566.git.zhaolei@cn.fujitsu.com>
 <tip-d740037fac7052e49450f6fa1454f1144a103b55@git.kernel.org>
 <20160404140312.GA28495@linux.vnet.ibm.com>
 <20160406065436.GB3078@gmail.com> <20160406203219.788ae7cf@kryten>
 <20160406110803.GI2906@worktop> <20160406215950.04bc3f0b@kryten>
 <20160406132637.GA2108@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160406132637.GA2108@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> * Anton Blanchard <anton@samba.org> [2016-04-06 21:59:50]:
> 
> > Looks good, and the patch below does fix the oops for me.
> > 
> > Anton
> > --
> > 
> > task_pt_regs() can return NULL for kernel threads, so add a check.
> > This fixes an oops at boot on ppc64.
> > 
> > Signed-off-by: Anton Blanchard <anton@samba.org>
> 
> Works for me too.
> 
> Reported-and-Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Could someone please re-send the fix, because it has not reached me nor lkml.

Thanks,

	Ingo
