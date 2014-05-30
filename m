Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 780971A06FF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 May 2014 08:39:47 +1000 (EST)
Message-ID: <1401489574.6603.225.camel@snotra.buserror.net>
Subject: Patch not showing up in patchwork (was Re: [PATCH] powerpc/booke64:
 wrap tlb lock and search in htw miss with FTR_SMT)
From: Scott Wood <scottwood@freescale.com>
To: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Date: Fri, 30 May 2014 17:39:34 -0500
In-Reply-To: <1401461955-18007-1-git-send-email-Laurentiu.Tudor@freescale.com>
References: <1401461955-18007-1-git-send-email-Laurentiu.Tudor@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-30 at 17:59 +0300, Laurentiu Tudor wrote:
> Virtualized environments expose a e6500 dual-threaded core
> as two single-threaded e6500 cores. Take advantage of this
> and get rid of the tlb lock and the trap-causing tlbsx in
> the htw miss handler by guarding with CPU_FTR_SMT, as it's
> already being done in the bolted tlb1 miss handler.
> 
> As seen in the results below, measurements done with lmbench
> random memory access latency test running under Freescale's
> Embedded Hypervisor, there is a ~34% improvement.
> 
> Memory latencies in nanoseconds - smaller is better
>     (WARNING - may not be correct, check graphs)
> ----------------------------------------------------
> Host       Mhz   L1 $   L2 $    Main mem    Rand mem
> ---------  ---   ----   ----    --------    --------
> smt       1665 1.8020   13.2    83.0         1149.7
> nosmt     1665 1.8020   13.2    83.0          758.1
> 
> Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
> Cc: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/mm/tlb_low_64e.S | 4 ++++
>  1 file changed, 4 insertions(+)

Any idea why this patch isn't showing up on the mailing list?  I see my
reply in the archives, but not the original patch.

-Scott
