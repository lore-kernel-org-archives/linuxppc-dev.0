Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjF9n57RPzDskJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 23:56:45 +1100 (AEDT)
Date: Tue, 14 Mar 2017 13:56:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
Message-ID: <20170314125626.GE3328@twins.programming.kicks-ass.net>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170306112228.GZ6515@twins.programming.kicks-ass.net>
 <2fc7e466-1675-ef27-b820-ef33ed0be7da@linux.vnet.ibm.com>
 <20170307102359.GE6515@twins.programming.kicks-ass.net>
 <78c1b95d-2e82-f998-74ba-ebb1fdf5bb45@linux.vnet.ibm.com>
 <20170313125041.GB3328@twins.programming.kicks-ass.net>
 <f73bc62f-d1cf-2599-95f9-69bd8e27da4e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f73bc62f-d1cf-2599-95f9-69bd8e27da4e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 14, 2017 at 02:31:51PM +0530, Madhavan Srinivasan wrote:

> >Huh? PPC hasn't yet implemented this? Then why are you fixing it?
> 
> yes, PPC hasn't implemented this (until now).

until now where?

> And did not understand "Then why are you fixing it?"

I see no implementation; so why are you poking at it.
