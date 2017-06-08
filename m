Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjsJt0rjFzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 14:05:18 +1000 (AEST)
In-Reply-To: <1496673659-18499-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>
Subject: Re: powerpc/kernel: Initialize load_tm on task creation
Message-Id: <3wjsJs5hyFz9s8N@ozlabs.org>
Date: Thu,  8 Jun 2017 14:05:17 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-06-05 at 14:40:59 UTC, Breno Leitao wrote:
> Currently tsk->thread.load_tm is not initialized in the task creation
> and can contain garbage on a new task.
> 
> This is an undesired behaviour, since it affects the timing to enable
> and disable the transactional memory laziness (disabling and enabling
> the MSR TM bit, which affects TM reclaim and recheckpoint in the
> scheduling process).
> 
> CC: Anton Blanchard <anton@samba.org>
> Fixes: 5d176f751ee3c6eededd984ad409bff201f436a7
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7f22ced4377628074e2ac25f41a88f

cheers
