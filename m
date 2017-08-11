Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPFv2kCLzDr38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:19:47 +1000 (AEST)
In-Reply-To: <1483968615-15850-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc/perf: Cleanup of PM_BR_CMPL vs. PM_BRU_CMPL in
 power9 event list
Message-Id: <3xTPFv1f6bz9t2W@ozlabs.org>
Date: Fri, 11 Aug 2017 22:19:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-01-09 at 13:30:14 UTC, Madhavan Srinivasan wrote:
> Fixes:34922527a2bcb ('powerpc/perf: Add power9 event list macros for generic and cache events')
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/93fc5ca9a0048c17b47582051940bf

cheers
