Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj80D2FDmzDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 20:03:08 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2E8rXa6073066
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 05:02:58 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 295we0trs1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 05:02:58 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 14 Mar 2017 19:02:56 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2E92irW26869762
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 20:02:52 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2E92JME021820
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 20:02:20 +1100
Subject: Re: [PATCH v2 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
To: Peter Zijlstra <peterz@infradead.org>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170306112228.GZ6515@twins.programming.kicks-ass.net>
 <2fc7e466-1675-ef27-b820-ef33ed0be7da@linux.vnet.ibm.com>
 <20170307102359.GE6515@twins.programming.kicks-ass.net>
 <78c1b95d-2e82-f998-74ba-ebb1fdf5bb45@linux.vnet.ibm.com>
 <20170313125041.GB3328@twins.programming.kicks-ass.net>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Stephane Eranian <eranian@google.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 14 Mar 2017 14:31:51 +0530
MIME-Version: 1.0
In-Reply-To: <20170313125041.GB3328@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f73bc62f-d1cf-2599-95f9-69bd8e27da4e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 13 March 2017 06:20 PM, Peter Zijlstra wrote:
> On Mon, Mar 13, 2017 at 04:45:51PM +0530, Madhavan Srinivasan wrote:
>>>   - should you not have fixed this in the tool only? This patch
>>>     effectively breaks ABI on big-endian architectures.
>> IIUC, we are the first BE user for this feature
>> (Kindly correct me if I am wrong), so technically we
>> are not breaking ABI here :) .  But let me also look  at
>> the dynamic conversion part.
> Huh? PPC hasn't yet implemented this? Then why are you fixing it?

yes, PPC hasn't implemented this (until now).
And did not understand "Then why are you fixing it?"

Maddy
>
