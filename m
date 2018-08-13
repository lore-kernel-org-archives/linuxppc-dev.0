Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptd50bHfzF0WR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:05 +1000 (AEST)
In-Reply-To: <20180430145558.4308-15-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [14/15] tty: hvc: introduce the hv_ops.flush operation for hvc
 drivers
Message-Id: <41ptd45pPpz9sCQ@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-30 at 14:55:57 UTC, Nicholas Piggin wrote:
> Use .flush to wait for drivers to flush their console outside of
> the spinlock, to reduce lock/irq latencies.
> 
> Flush the hvc console driver after each write, which can help
> messages make it out to the console after a crash.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9f65b81f36e31563c5a5e4df3b3b8b

cheers
