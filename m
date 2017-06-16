Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpwDr2l31zDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 19:34:20 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5G9Xia7029922
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 05:34:17 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b48hwuj8u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 05:34:17 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 16 Jun 2017 03:34:16 -0600
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] ppc64/perf: Fix oops when kthread execs user process
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1497534408-4591-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <87fuf0wm5j.fsf@concordia.ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, mingo@kernel.org,
 peterz@infradead.org, acme@kernel.org,
 alexander.shishkin@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Jun 2017 15:04:00 +0530
MIME-Version: 1.0
In-Reply-To: <87fuf0wm5j.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5943A608.30207@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Friday 16 June 2017 10:42 AM, Michael Ellerman wrote:
>
> That function (perf_get_regs_user()) didn't exist until 4.7, ie:
>
> ed4a4ef85cf5 ("powerpc/perf: Add support for sampling interrupt register state")
>
> So there must be something else going on.
>
> I'll hold off on merging this until we've worked it out.

That was my mistake. It's v4.7 not v4.4.

Thanks,
Ravi
