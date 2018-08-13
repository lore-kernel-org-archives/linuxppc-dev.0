Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptd40bNYzF0WS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:04 +1000 (AEST)
In-Reply-To: <20180430145558.4308-14-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [13/15] tty: hvc: hvc_write may sleep
Message-Id: <41ptd34Q5zz9sC7@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-30 at 14:55:56 UTC, Nicholas Piggin wrote:
> Rework the hvc_write loop to drop and re-take the spinlock on each
> iteration, add a cond_resched. Don't bother with an initial hvc_push
> initially, which makes the logic simpler -- just do a hvc_push on
> each time around the loop.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/550ddadcc7580ec2a6c22d4ed04291

cheers
