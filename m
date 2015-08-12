Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412D71A0567
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 16:05:56 +1000 (AEST)
Message-ID: <1439359555.27815.1.camel@ellerman.id.au>
Subject: Re: [PATCH 8/8] powerpc/xmon: Add some more elements to the
 existing PACA dump list
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
Date: Wed, 12 Aug 2015 16:05:55 +1000
In-Reply-To: <1438153805-31828-8-git-send-email-khandual@linux.vnet.ibm.com>
References: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1438153805-31828-8-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-29 at 12:40 +0530, Anshuman Khandual wrote:
> This patch adds a set of new elements to the existing PACA dump list
> inside an xmon session which can be listed below improving the overall
> xmon debug support.
> 
> (1) hmi_event_available
> (2) dscr_default
> (3) vmalloc_sllp
> (4) slb_cache_ptr
> (5) sprg_vdso
> (6) tm_scratch
> (7) core_idle_state_ptr
> (8) thread_idle_state
> (9) thread_mask
> (10) slb_shadow
> (11) pgd
> (12) kernel_pgd
> (13) tcd_ptr
> (14) mc_kstack
> (15) crit_kstack
> (16) dbg_kstack
> (17) user_time
> (18) system_time
> (19) user_time_scaled
> (20) starttime
> (21) starttime_user
> (22) startspurr
> (23) utime_sspurr
> (24) stolen_time

Adding these makes the paca display much longer than 24 lines. I know in
general we don't worry too much about folks on 80x24 green screens, but it's
nice if xmon works OK on those. Or on virtual consoles that don't scroll for
whatever reason.

So I'm going to hold off on this one until we have a way to display some of the
paca. I have an idea for that and will send a patch if it works.

cheers
