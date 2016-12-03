Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW80P5LMxzDw2W
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:28:21 +1100 (AEDT)
In-Reply-To: <20161128165044.7375.36918.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pserie: Use lmb_is_removable() to check removability
Message-Id: <3tW80P4N7tz9t2n@ozlabs.org>
Date: Sat,  3 Dec 2016 22:28:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-28 at 16:50:45 UTC, Nathan Fontenot wrote:
> We should be using lmb_is_removable() to validate that enough LMBs
> are available to remove when doing a remove by count. This will check
> that the LMB is owned by the system and it is considered removable.
> This patch also adds a pr_info() notification to report the LMB count
> to remove was not satisfied.
> 
> What we do now is just check that there are enough LMBs owned by the
> system when validating there are enough LMBs to remove. This can
> lead to situations where there are enough LMBs owned by the system
> but not enough that are considered removable. This results in having
> to bail out of the remove operation instead of just failing the request
> that we should have known wouldn't succeed.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2db029ef58ab7c47cecab5fe73fa6e

cheers
