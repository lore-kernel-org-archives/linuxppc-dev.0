Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8xQ6sS7zF2ML
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:30 +1100 (AEDT)
In-Reply-To: <20180327043724.13862-2-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kvm-ppc@vger.kernel.org, npiggin@gmail.com, david@gibson.dropbear.id.au,
 linuxppc-dev@lists.ozlabs.org, pedromfc@linux.vnet.ibm.com
Subject: Re: [v3,1/8] powerpc: Add ppc_breakpoint_available()
Message-Id: <40B8xQ0fd0z9s1P@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-03-27 at 04:37:17 UTC, Michael Neuling wrote:
> Add ppc_breakpoint_available() to determine if a breakpoint is
> available currently via the DAWR or DABR.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/404b27d66ed657ebccb08a9c8f8f65

cheers
