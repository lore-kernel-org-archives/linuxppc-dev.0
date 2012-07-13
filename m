Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by ozlabs.org (Postfix) with ESMTP id 45F862C02FC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 16:53:28 +1000 (EST)
Date: Fri, 13 Jul 2012 15:33:10 +0900
From: Simon Horman <horms@verge.net.au>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: Re: [PATCH] [ppc] Do not reserve cpu spin-table for crash kernel
Message-ID: <20120713063309.GF19512@verge.net.au>
References: <CAEsOVNeg2aogCwCy-v3ez4cC4VPF79A4PWRaO2ohDj_ypqCWmg@mail.gmail.com>
 <20120524060933.14035.42732.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120524060933.14035.42732.stgit@suzukikp.in.ibm.com>
Cc: B29882@freescale.com, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 24, 2012 at 11:39:45AM +0530, Suzuki K. Poulose wrote:
> As of now, the kexec reserves the spin-table for all the CPUs
> on an SMP machine. The spin-table is pointed to by the 
> cpu-release-addr property in the device-tree. Reserving the
> spin-table in the crash kernel will cause a BUG(), if the table
> lies outside the memory reserved for the crashkernel.
> 
> Disable reserving the spin-table regions and use maxcpus=1 to 
> use only the crashing CPU to boot the crash kernel.
> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>

Thanks, applied.

Sorry for not seeing this (much) earlier.
