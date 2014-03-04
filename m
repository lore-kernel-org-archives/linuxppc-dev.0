Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BAA912C00D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 09:12:13 +1100 (EST)
Date: Tue, 4 Mar 2014 23:12:09 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] sched: Remove unused mc_capable() and
 smt_capable()
In-Reply-To: <20140304210737.16893.54289.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.02.1403042311480.18573@ionos.tec.linutronix.de>
References: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140304210737.16893.54289.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tue, 4 Mar 2014, Bjorn Helgaas wrote:

> Remove mc_capable() and smt_capable().  Neither is used.
> 
> Both were added by 5c45bf279d37 ("sched: mc/smt power savings sched
> policy").  Uses of both were removed by 8e7fbcbc22c1 ("sched: Remove stale
> power aware scheduling remnants and dysfunctional knobs").
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/arm/include/asm/topology.h      |    3 ---
>  arch/ia64/include/asm/topology.h     |    1 -
>  arch/mips/include/asm/topology.h     |    4 ----
>  arch/powerpc/include/asm/topology.h  |    1 -
>  arch/sparc/include/asm/topology_64.h |    2 --
>  arch/x86/include/asm/topology.h      |    6 ------
>  6 files changed, 17 deletions(-)

Acked-by: Thomas Gleixner <tglx@linutronix.de>
