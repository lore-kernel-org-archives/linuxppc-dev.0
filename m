Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3Qlb05wvzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 23:10:19 +1100 (AEDT)
In-Reply-To: <1483968615-15850-2-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [2/2] powerpc/perf: fix PM_BR_CMPL event code for power9
Message-Id: <3v3QlZ6XJ0z9t0q@ozlabs.org>
Date: Wed, 18 Jan 2017 23:10:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-01-09 at 13:30:15 UTC, Madhavan Srinivasan wrote:
> Use 0x10012 event code for PM_BR_CMPL event in
> power9 event list instead of current 0x40060.
> 
> Fixes:34922527a2bcb ('powerpc/perf: Add power9 event list macros for generic and cache events')
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d89f473ff6f84872e761419f7233d6

cheers
