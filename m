Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgL25Mn9zDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:35:54 +1000 (AEST)
In-Reply-To: <20170601053440.28976-2-rashmica.g@gmail.com>
To: Rashmica Gupta <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, npiggin@gmail.com, bsingharora@gmail.com, oohall@gmail.com,
 khandual@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: Re: [v3,
 2/3] powerpc/powernv: Enable removal of memory for in memory tracing
Message-Id: <3xjgL23qFpz9t2y@ozlabs.org>
Date: Thu, 31 Aug 2017 21:35:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-01 at 05:34:39 UTC, Rashmica Gupta wrote:
> The hardware trace macro feature requires access to a chunk of real
> memory. This patch provides a debugfs interface to do this. By
> writing an integer containing the size of memory to be unplugged into
> /sys/kernel/debug/powerpc/memtrace/enable, the code will attempt to
> remove that much memory from the end of each NUMA node.
> 
> This patch also adds additional debugsfs files for each node that
> allows the tracer to interact with the removed memory, as well as
> a trace file that allows userspace to read the generated trace.
> 
> Note that this patch does not invoke the hardware trace macro, it
> only allows memory to be removed during runtime for the trace macro
> to utilise.
> 
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9d5171a8f248b1b0e69329bf141e17

cheers
