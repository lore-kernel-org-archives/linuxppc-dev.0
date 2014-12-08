Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CEB061A04F2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 14:33:58 +1100 (AEDT)
Date: Mon, 8 Dec 2014 14:33:51 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/4] powerpc/powernv: Enable Offline CPUs to enter
 deep idle states
Message-ID: <20141208033351.GA4437@drongo>
References: <1417678103-32571-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1417678103-32571-3-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417678103-32571-3-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, "Preeti U. Murthy" <preeti@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 04, 2014 at 12:58:21PM +0530, Shreyas B. Prabhu wrote:
> From: "Preeti U. Murthy" <preeti@linux.vnet.ibm.com>
> 
> The secondary threads should enter deep idle states so as to gain maximum
> powersavings when the entire core is offline. To do so the offline path
> must be made aware of the available deepest idle state. Hence probe the
> device tree for the possible idle states in powernv core code and
> expose the deepest idle state through flags.
> 
> Since the  device tree is probed by the cpuidle driver as well, move
> the parameters required to discover the idle states into an appropriate
> common place to both the driver and the powernv core code.
> 
> Another point is that fastsleep idle state may require workarounds in
> the kernel to function properly. This workaround is introduced in the
> subsequent patches. However neither the cpuidle driver or the hotplug
> path need be bothered about this workaround.
> 
> They will be taken care of by the core powernv code.
> 
> Originally-by: Srivatsa S. Bhat <srivatsa@mit.edu>
> Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>

Reviewed-by: Paul Mackerras <paulus@samba.org>
