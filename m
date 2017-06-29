Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKJ4xgvzDr4n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:08 +1000 (AEST)
In-Reply-To: <149634598024.11266.1878020879845577140.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [v2] powerpc/fadump: add reschedule point while releasing memory
Message-Id: <3wyzKJ3N38z9s7v@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-01 at 19:40:10 UTC, Hari Bathini wrote:
> Around 95% of memory is reserved by fadump/capture kernel. All this
> memory is freed, one page at a time, on writing '1' to the node
> /sys/kernel/fadump_release_mem. On systems with large memory, this
> can take a long time to complete, leading to soft lockup warning
> messages. To avoid this, add reschedule points at regular intervals.
> 
> Also, while memblock_reserve() implicitly takes care of holes in the
> given memory range while reserving memory, those holes need to be
> taken care of while releasing memory as memory is freed one page at
> a time. Add support to skip holes while releasing memory.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/68fa6478e3b1fab7077d390070ed45

cheers
