Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg360MtLzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:59:46 +1000 (AEST)
In-Reply-To: <20180201010746.413-1-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: gromero@linux.vnet.ibm.com
Subject: Re: powerpc/tm: Remove struct thread_info param from
 tm_reclaim_thread()
Message-Id: <41Zg353jZVz9s1x@ozlabs.org>
Date: Tue, 24 Jul 2018 23:59:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-02-01 at 01:07:46 UTC, Cyril Bur wrote:
> tm_reclaim_thread() doesn't use the parameter anymore, both callers have
> to bother getting it as they have no need for a struct thread_info
> either.
> 
> Just remove it and adjust the callers.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/edd00b830731be468fd3caf7f9154d

cheers
