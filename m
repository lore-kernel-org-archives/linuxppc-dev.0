Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DE8B1A0D87
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 14:56:52 +1100 (AEDT)
In-Reply-To: <20150128021044.11166.81418.stgit@preeti.in.ibm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, mpe@ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [V2] cpuidle/powernv: Read target_residency value of idle states
 from DT if available
Message-Id: <20150130035652.3C252140277@ozlabs.org>
Date: Fri, 30 Jan 2015 14:56:52 +1100 (AEDT)
Cc: rafael.j.wysocki@intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-28-01 at 02:13:06 UTC, Preeti U Murthy wrote:
> The device tree now exposes the residency values for different idle states. Read
> these values instead of calculating residency from the latency values. The values
> exposed in the DT are validated for optimal power efficiency. However to maintain
> compatibility with the older firmware code which does not expose residency
> values, use default values as a fallback mechanism. While at it, handle some
> cleanups.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

This looks good to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

I'm assuming Rafael will take it.

cheers
