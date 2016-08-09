Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sRs3tCGzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:33 +1000 (AEST)
In-Reply-To: <147039864368.4007.8950616642100181791.stgit@jupiter.in.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [v3,1/2] powernv: Move IDLE_STATE_ENTER_SEQ macro to cpuidle.h
Message-Id: <3s7sRs2hhsz9t1L@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-05-08 at 12:04:04 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Move IDLE_STATE_ENTER_SEQ macro to cpuidle.h so that MCE handler changes
> in subsequent patch can use it.
> 
> No functionality change.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/98d8821a47f3fd7354d3ab87ad

cheers
