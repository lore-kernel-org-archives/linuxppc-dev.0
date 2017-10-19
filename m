Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHbzD08lLzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 15:48:24 +1100 (AEDT)
In-Reply-To: <e7dde327-f78a-31a4-ce0f-8fbf67459f64@linux.vnet.ibm.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
Subject: Re: [V14,1/4] powerpc/vphn: Update CPU topology when VPHN enabled
Message-Id: <3yHbzC4qg0z9tXC@ozlabs.org>
Date: Thu, 19 Oct 2017 15:48:23 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-08 at 20:47:27 UTC, Michael Bringmann wrote:
> powerpc/vphn: On Power systems with shared configurations of CPUs
> and memory, there are some issues with the association of additional
> CPUs and memory to nodes when hot-adding resources.  This patch
> corrects the currently broken capability to set the topology for
> shared CPUs in LPARs.  At boot time for shared CPU lpars, the
> topology for each CPU was being set to node zero.  Now when
> numa_update_cpu_topology() is called appropriately, the Virtual
> Processor Home Node (VPHN) capabilities information provided by the
> pHyp allows the appropriate node in the shared configuration to be
> selected for the CPU.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/17f444c0549f2ce037646871e748cf

cheers
