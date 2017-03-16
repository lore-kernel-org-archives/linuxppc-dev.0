Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkHkK2q48zDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 16:55:05 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G5rf7Z049831
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 01:54:51 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2971kukfnx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 01:54:51 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 15:54:48 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G5scvO51642440
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 16:54:46 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G5sCpJ003754
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 16:54:13 +1100
Subject: Re: [PATCH v2 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
To: Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170306112228.GZ6515@twins.programming.kicks-ass.net>
 <2fc7e466-1675-ef27-b820-ef33ed0be7da@linux.vnet.ibm.com>
 <20170307102359.GE6515@twins.programming.kicks-ass.net>
 <78c1b95d-2e82-f998-74ba-ebb1fdf5bb45@linux.vnet.ibm.com>
 <20170313125041.GB3328@twins.programming.kicks-ass.net>
 <f73bc62f-d1cf-2599-95f9-69bd8e27da4e@linux.vnet.ibm.com>
 <20170314125626.GE3328@twins.programming.kicks-ass.net>
 <8737efukm8.fsf@concordia.ellerman.id.au> <20170315122340.GP3093@worktop>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Stephane Eranian <eranian@google.com>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 16 Mar 2017 11:23:47 +0530
MIME-Version: 1.0
In-Reply-To: <20170315122340.GP3093@worktop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6234de80-f8b8-fe98-f307-dc2b69fe324f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 15 March 2017 05:53 PM, Peter Zijlstra wrote:
> On Wed, Mar 15, 2017 at 05:20:15PM +1100, Michael Ellerman wrote:
>
>>> I see no implementation; so why are you poking at it.
>> Maddy has posted an implementation of the kernel part for powerpc in
>> patch 2 of this series, but maybe you're not on Cc?
> I am not indeed. That and a completely inadequate Changelog have lead to
> great confusion.

Yes. my bad. I will send out a v3 today and will CC. Also will add
ellerman's explanation to the commit message.

Sorry for the confusion.

Maddy
