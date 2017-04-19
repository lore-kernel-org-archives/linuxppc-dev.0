Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7bcz00W7zDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 08:04:19 +1000 (AEST)
In-Reply-To: <1491875470-17904-2-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: wangnan0@huawei.com, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 peterz@infradead.org, linux-kernel@vger.kernel.org, acme@kernel.org,
 ast@kernel.org, alexander.shishkin@linux.intel.com, mingo@redhat.com,
 paulus@samba.org, eranian@google.com, andrew.donnellan@au1.ibm.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,
 1/6] powerpc/perf: Define big-endian version of perf_mem_data_src
Message-Id: <3w7bcy6DMrz9s7B@ozlabs.org>
Date: Thu, 20 Apr 2017 08:04:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-11 at 01:51:05 UTC, Madhavan Srinivasan wrote:
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> perf_mem_data_src is an union that is initialized via the ->val field
> and accessed via the bitmap fields. For this to work on big endian
> platforms (Which is broken now), we also need a big-endian represenation
> of perf_mem_data_src. i.e, in a big endian system, if user request
> PERF_SAMPLE_DATA_SRC (perf report -d), will get the default value from
> perf_sample_data_init(), which is PERF_MEM_NA. Value for PERF_MEM_NA
> is constructed using shifts:
...
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8c5073db0ee680c7e70e123918c9b2

cheers
