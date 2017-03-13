Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhd5P4t1bzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 23:50:49 +1100 (AEDT)
Date: Mon, 13 Mar 2017 13:50:41 +0100
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
Message-ID: <20170313125041.GB3328@twins.programming.kicks-ass.net>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170306112228.GZ6515@twins.programming.kicks-ass.net>
 <2fc7e466-1675-ef27-b820-ef33ed0be7da@linux.vnet.ibm.com>
 <20170307102359.GE6515@twins.programming.kicks-ass.net>
 <78c1b95d-2e82-f998-74ba-ebb1fdf5bb45@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <78c1b95d-2e82-f998-74ba-ebb1fdf5bb45@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 13, 2017 at 04:45:51PM +0530, Madhavan Srinivasan wrote:
> >  - should you not have fixed this in the tool only? This patch
> >    effectively breaks ABI on big-endian architectures.
> 
> IIUC, we are the first BE user for this feature
> (Kindly correct me if I am wrong), so technically we
> are not breaking ABI here :) .  But let me also look  at
> the dynamic conversion part.

Huh? PPC hasn't yet implemented this? Then why are you fixing it?
