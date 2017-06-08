Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjsJs0xfmzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 14:05:17 +1000 (AEST)
In-Reply-To: <1495786107-341-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/perf: Fix Power9 test_adder field
Message-Id: <3wjsJs06qWz9s8Y@ozlabs.org>
Date: Thu,  8 Jun 2017 14:05:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-05-26 at 08:08:27 UTC, Madhavan Srinivasan wrote:
> Commit 8d911904f3ce4 ('powerpc/perf: Add restrictions to PMC5 in power9 DD1')
> was added to restrict the use of PMC5 in Power9 DD1. Intend is to diable
> the use of PMC5 using raw event code. Commit instead of updating "power9_isa207_pmu"
> structure, updated "power9_pmu" structure. Patch to fix the same.
> 
> Fixes: 8d911904f3ce4 ('powerpc/perf: Add restrictions to PMC5 in power9 DD1')
> Reported-by: Shriya <shriyak@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Tested-by: Shriya <shriyak@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8c218578fcbbbdb10416c8614658bf

cheers
