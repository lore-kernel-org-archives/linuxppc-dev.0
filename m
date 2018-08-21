Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vnBP2RdqzF1Rx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 20:35:25 +1000 (AEST)
In-Reply-To: <153453843169.1010.11894303551198228940.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: powerpc/fadump: cleanup crash memory ranges support
Message-Id: <41vnBP0xVPz9s7X@ozlabs.org>
Date: Tue, 21 Aug 2018 20:35:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-17 at 20:40:56 UTC, Hari Bathini wrote:
> Commit 1bd6a1c4b80a ("powerpc/fadump: handle crash memory ranges array
> index overflow") changed crash memory ranges to a dynamic array that
> is reallocated on-demand with krealloc(). The relevant header for this
> call was not included. The kernel compiles though. But be cautious and
> add the header anyway.
> 
> Also, memory allocation logic in fadump_add_crash_memory() takes care
> of memory allocation for crash memory ranges in all scenarios. Drop
> unnecessary memory allocation in fadump_setup_crash_memory_ranges().
> 
> Fixes: 1bd6a1c4b80a ("powerpc/fadump: handle crash memory ranges array index overflow")
> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a58183138cb72059a0c278f8370a47

cheers
