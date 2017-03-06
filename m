Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcSS51gDpzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 05:07:32 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v26I4cbU067878
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 13:07:29 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 291cqvr4vg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 13:07:29 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 6 Mar 2017 23:37:25 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9C899125804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 23:37:38 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v26I7NTQ12517436
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 23:37:23 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v26I7LRH022105
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 23:37:22 +0530
Date: Mon, 6 Mar 2017 23:37:20 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com
Cc: mingo@kernel.org, mpe@ellerman.id.au, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mhiramat@kernel.org, ananth@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] arm: kprobes: remove kprobe_exceptions_notify
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
 <46a640f65b86650d3a7d64a577dd441838de1c20.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46a640f65b86650d3a7d64a577dd441838de1c20.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <20170306180720.GC7467@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/08 01:24AM, Naveen N Rao wrote:
> ... as the weak variant will do.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/arm/probes/kprobes/core.c     | 10 ----------
>  arch/arm64/kernel/probes/kprobes.c |  6 ------
>  2 files changed, 16 deletions(-)

With the generic changes in this series now in -rc1, can you please pick 
this up?

Thanks,
Naveen
