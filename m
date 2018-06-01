Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y86R2MPMzF0kW
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:54:55 +1000 (AEST)
In-Reply-To: <1525755624-9802-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/perf: Update raw-event code encoding comment for power8
Message-Id: <40y86R1ctpz9s1p@ozlabs.org>
Date: Sat,  2 Jun 2018 01:54:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-08 at 05:00:24 UTC, Madhavan Srinivasan wrote:
> Comment explanning the raw event code encoding for Power8 was
> moved to isa207_common.h file when re-factoring the code to
> support power9. But then Power9 pmu branched out due to changes
> specific to power9. So move the encoding comment back to power8-pmu.c
> Just comment movement and no logic change.
> 
> Fixes: 4d3576b20716 ('powerpc/perf: factor out power8 pmu macros and defines')
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/458c70173daaaa823faeb5b4031bf8

cheers
