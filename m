Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [59.145.155.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA480DE154
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 17:48:22 +1100 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp09.in.ibm.com (8.13.1/8.13.1) with ESMTP id n2B6NW5J032287
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 11:53:32 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2B6mOab4210914
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 12:18:24 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n2B6mFEb029384
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 12:18:15 +0530
Message-ID: <49B75EAE.4080708@in.ibm.com>
Date: Wed, 11 Mar 2009 12:18:14 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: [RESEND GIT PATCH tj-percpu] percpu: fix spurious alignment WARN
	in legacy SMP percpu allocator
References: <20090310195534.8f8f3c7a.sfr@canb.auug.org.au>
	<49B67552.5070307@in.ibm.com> <49B73B15.3040101@in.ibm.com>
	<49B75215.5010707@kernel.org>
In-Reply-To: <49B75215.5010707@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tejun Heo wrote:
> Impact: remove spurious WARN on legacy SMP percpu allocator
>
> Commit f2a8205c4ef1af917d175c36a4097ae5587791c8 incorrectly added too
> tight WARN_ON_ONCE() on alignments for UP and legacy SMP percpu
> allocator.  Commit e317603694bfd17b28a40de9d65e1a4ec12f816e fixed it
> for UP but legacy SMP allocator was forgotten.  Fix it.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Sachin P. Sant <sachinp@in.ibm.com>
> ---
Thanks. The patch fixes the warning.

Tested-by : Sachin Sant <sachinp@in.ibm.com>


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
