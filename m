Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8W9m5Wg2zDqRR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:46:36 +1000 (AEST)
In-Reply-To: <20160810054446.5624-1-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: ptrace: tm_reclaim_current() in flush_tmregs_to_thread()
Message-Id: <3s8W9m4JMYz9t2H@ozlabs.org>
Date: Wed, 10 Aug 2016 22:46:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-10-08 at 05:44:46 UTC, Cyril Bur wrote:
> There was an assumption that flush_tmregs_to_thread() would only be
> called for a task which is not current. And a warning could be shown
> to indicate that current is being ptraced.
> 
> In the event of a core dump the current threads state is needed. This
> means that flush_tmregs_to_thread() must do its best to flush even for
> current.
> 
> This patch also moves flush_tmregs_to_thread() into ptrace.c as it is
> only called from that file.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c7a318ba868c61fc9be710a497

cheers
