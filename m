Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW3b3djjzDqZV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:36:11 +1100 (AEDT)
In-Reply-To: <925b1b5f2d28b5015354405af72bf23d21a1c5c4.1487090656.git.ldufour@linux.vnet.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/3] powerpc/mm: move mmap_sem unlock up from do_sigbus
Message-Id: <3vnW3b2R4Fz9s83@ozlabs.org>
Date: Tue, 21 Mar 2017 22:36:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-14 at 16:45:10 UTC, Laurent Dufour wrote:
> Move mmap_sem releasing in the do_sigbus()'s unique caller : mm_fault_error()
> 
> No functional changes.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c2294e0ffe741c8b34c630a71c7dc4

cheers
