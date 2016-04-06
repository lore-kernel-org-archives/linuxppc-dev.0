Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qg63b3zLZzDq6Y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 23:27:55 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 6 Apr 2016 23:27:54 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 622BE3578058
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 23:27:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u36DRUSf62259404
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 23:27:39 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u36DR5Ui015253
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 23:27:06 +1000
Date: Wed, 6 Apr 2016 18:56:37 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 tglx@linutronix.de, efault@gmx.de, htejun@gmail.com,
 linux-kernel@vger.kernel.org, tj@kernel.org,
 torvalds@linux-foundation.org, zhaolei@cn.fujitsu.com,
 yangds.fnst@cn.fujitsu.com, hpa@zytor.com,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] sched/cpuacct: Check for NULL when using task_pt_regs()
Message-ID: <20160406132637.GA2108@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <aa171da036b520b51c79549e9b3215d29473f19d.1458635566.git.zhaolei@cn.fujitsu.com>
 <tip-d740037fac7052e49450f6fa1454f1144a103b55@git.kernel.org>
 <20160404140312.GA28495@linux.vnet.ibm.com>
 <20160406065436.GB3078@gmail.com> <20160406203219.788ae7cf@kryten>
 <20160406110803.GI2906@worktop> <20160406215950.04bc3f0b@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160406215950.04bc3f0b@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Anton Blanchard <anton@samba.org> [2016-04-06 21:59:50]:

> Looks good, and the patch below does fix the oops for me.
> 
> Anton
> --
> 
> task_pt_regs() can return NULL for kernel threads, so add a check.
> This fixes an oops at boot on ppc64.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Works for me too.

Reported-and-Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju
