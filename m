Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptd31XTVzF0WS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:03 +1000 (AEST)
In-Reply-To: <20180430145558.4308-13-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [12/15] tty: hvc: hvc_poll may sleep
Message-Id: <41ptd251rjz9sBJ@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-30 at 14:55:55 UTC, Nicholas Piggin wrote:
> Introduce points where hvc_poll drops the lock, enables interrupts,
> and reschedules.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cfb5946b55f1dfd19e042feae1fbff

cheers
