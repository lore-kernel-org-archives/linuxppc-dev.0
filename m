Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fv5f2Gs5zF28T
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 02:03:34 +1000 (AEST)
In-Reply-To: <20171117140807.22105-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/3] powerpc/64s/idle: POWER9 implement a separate idle stop
 function for hotplug
Message-Id: <40Fv5c0X41z9s4b@ozlabs.org>
Date: Wed,  4 Apr 2018 02:03:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-11-17 at 14:08:05 UTC, Nicholas Piggin wrote:
> Implement a new function to invoke stop, power9_offline_stop, which is
> like power9_idle_stop but used by the cpu hotplug code.
> 
> Move KVM secondary state manipulation code to the offline case.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3d4fbffdd703d2b968db443911f214

cheers
