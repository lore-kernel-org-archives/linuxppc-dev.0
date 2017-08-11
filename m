Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPFx2WXxzDr38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:19:49 +1000 (AEST)
In-Reply-To: <1500960951-18017-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/perf: Update default sdar_mode value for power9
Message-Id: <3xTPFx1lWRz9t36@ozlabs.org>
Date: Fri, 11 Aug 2017 22:19:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-07-25 at 05:35:51 UTC, Madhavan Srinivasan wrote:
> Commit 20dd4c624d251 ('powerpc/perf: Fix SDAR_MODE value for continous
> sampling on Power9') set the default sdar_mode value in MMCRA[SDAR_MODE]
> to be used as 0b01 (Update on TLB miss). And this value is set if sdar_mode
> from event is zero, or we are in continous sampling mode in power9 dd1.
> 
> But it is preferred to have the sdar_mode value for power9 as
> 0b10 (Update on dcache miss) for better sampling updates instead
> of 0b01 (Update on TLB miss).
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Acked-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7aa345d84245a75760fc35a385fc55

cheers
