Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR4QW1FLlzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 22:33:39 +1100 (AEDT)
In-Reply-To: <1486985574-32608-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: powerpc/perf: Avoid FAB_*_MATCH checks for power9
Message-Id: <3vR4QW0PRTz9sDB@ozlabs.org>
Date: Sun, 19 Feb 2017 22:33:38 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-02-13 at 11:32:54 UTC, Madhavan Srinivasan wrote:
> Since power9 does not support FAB_*_MATCH bits in MMCR1,
> avoid these checks for power9. For this, patch factor out
> code in isa207_get_constraint() to retain these checks
> only for power8.
> 
> Patch also updates the comment in power9-pmu raw event
> encode layout to remove FAB_*_MATCH.
> 
> Finally for power9, patch adds additional check for
> threshold events when adding the thresh mask and value in
> isa207_get_constraint().
> 
> fixes: 7ffd948fae4c ('powerpc/perf: factor out power8 pmu functions')
> fixes: 18201b204286 ('powerpc/perf: power9 raw event format encoding')
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/78a16d9fc1206e1a484b6ac9634875

cheers
