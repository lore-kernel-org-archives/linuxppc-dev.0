Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DCEB1A02EF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 11:30:42 +1100 (AEDT)
In-Reply-To: <20160130030710.GA7330@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/2] powerpc/perf/hv-24x7: Fix usage with chip events
Message-Id: <20160311003041.E7200140C3A@ozlabs.org>
Date: Fri, 11 Mar 2016 11:30:41 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-30-01 at 03:07:10 UTC, Sukadev Bhattiprolu wrote:
> >From 9b5848ce1834a4d82fc251022035d36d9e26b500 Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Sat, 23 Jan 2016 03:58:12 -0500
> Subject: [PATCH 1/2] powerpc/perf/hv-24x7: Fix usage with chip events.
> 
> 24x7 counters can belong to different domains (core, chip, virtual CPU
> etc). For events in the 'chip' domain, sysfs entry currently looks like:
> 
> 	$ cd /sys/bus/event_source/devices/hv_24x7/events
> 	$ cat PM_XLINK_CYCLES__PHYS_CHIP
> 	domain=0x1,offset=0x230,core=?,lpar=0x0
...

> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e5a5886d7ae32b7afebfffecca

cheers
