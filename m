Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7bDK72lyzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 22:46:41 +1000 (AEST)
In-Reply-To: <20170618235128.20472-1-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mikey@neuling.org, maddy@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/perf: Add POWER9 alternate PM_RUN_CYC and
 PM_RUN_INST_CMPL events
Message-Id: <3x7bDK5g0wz9s7g@ozlabs.org>
Date: Thu, 13 Jul 2017 22:46:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-06-18 at 23:51:28 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> Similar to POWER8, POWER9 can count run cycles and run instructions
> completed on more than one PMU.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/3f0bd8dad0db73f5d71b355aec5ab3

cheers
