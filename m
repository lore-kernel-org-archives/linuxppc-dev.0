Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblFx0NZBzDqpp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:05 +1100 (AEDT)
In-Reply-To: <1507869401-4715-1-git-send-email-shriyak@linux.vnet.ibm.com>
To: Shriya <shriyak@linux.vnet.ibm.com>, mikey@neuling.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: ego@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shriya <shriyak@linux.vnet.ibm.com>,
 shilpa.bhat@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] cpufreq: powernv: Fix the frequency read by /proc/cpuinfo
Message-Id: <3yblFw5vgVz9sPs@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:04 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-10-13 at 04:36:41 UTC, Shriya wrote:
> The call to /proc/cpuinfo in turn calls cpufreq_quick_get() which
> returns the last frequency requested by the kernel, but may not
> reflect the actual frequency the processor is running at.
> This patch makes a call to cpufreq_get() instead which returns the
> current frequency reported by the hardware.
> 
> Fixes : commit fb5153d05a7d ("powerpc: powernv: Implement
> ppc_md.get_proc_freq()")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Shriya <shriyak@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cd77b5ce208c153260ed7882d8910f

cheers
