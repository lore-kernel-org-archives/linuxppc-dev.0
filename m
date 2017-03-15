Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjrPT0SDjzDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 23:23:57 +1100 (AEDT)
Date: Wed, 15 Mar 2017 13:23:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
Message-ID: <20170315122340.GP3093@worktop>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170306112228.GZ6515@twins.programming.kicks-ass.net>
 <2fc7e466-1675-ef27-b820-ef33ed0be7da@linux.vnet.ibm.com>
 <20170307102359.GE6515@twins.programming.kicks-ass.net>
 <78c1b95d-2e82-f998-74ba-ebb1fdf5bb45@linux.vnet.ibm.com>
 <20170313125041.GB3328@twins.programming.kicks-ass.net>
 <f73bc62f-d1cf-2599-95f9-69bd8e27da4e@linux.vnet.ibm.com>
 <20170314125626.GE3328@twins.programming.kicks-ass.net>
 <8737efukm8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8737efukm8.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 15, 2017 at 05:20:15PM +1100, Michael Ellerman wrote:

> > I see no implementation; so why are you poking at it.
> 
> Maddy has posted an implementation of the kernel part for powerpc in
> patch 2 of this series, but maybe you're not on Cc?

I am not indeed. That and a completely inadequate Changelog have lead to
great confusion.
