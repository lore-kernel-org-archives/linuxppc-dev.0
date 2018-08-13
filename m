Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptd13zL4zF0WS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:01 +1000 (AEST)
In-Reply-To: <20180430145558.4308-12-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [11/15] tty: hvc: hvc_poll break hv read loop
Message-Id: <41ptd06Yfbz9sCX@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-30 at 14:55:54 UTC, Nicholas Piggin wrote:
> Avoid looping with the spinlock held while there is read data
> being returned from the hv driver. Instead note if the entire
> size returned by tty_buffer_request_room was read, and request
> another read poll.
> 
> This limits the critical section lengths, and provides more
> even service to other consoles in case there is a pathological
> condition.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ec97eaad1383ab2500fcf9a07ade60

cheers
