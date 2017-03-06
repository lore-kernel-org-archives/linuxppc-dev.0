Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcHSp0XyqzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 22:22:34 +1100 (AEDT)
Date: Mon, 6 Mar 2017 12:22:28 +0100
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
Message-ID: <20170306112228.GZ6515@twins.programming.kicks-ass.net>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 06, 2017 at 04:13:08PM +0530, Madhavan Srinivasan wrote:
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> perf_mem_data_src is an union that is initialized via the ->val field
> and accessed via the bitmap fields. For this to work on big endian
> platforms, we also need a big-endian represenation of perf_mem_data_src.

Doesn't this break interpreting the data on a different endian machine?
