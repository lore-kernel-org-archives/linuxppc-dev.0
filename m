Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYjck42RmzDr4X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 22:51:02 +1000 (AEST)
In-Reply-To: <9f412d91a41af6e0a8eb44413a40e154f02bdd3a.1502135910.git.geoff@infradead.org>
To: Geoff Levand <geoff@infradead.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Jens Axboe <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org,
 Markus Elfring <elfring@users.sourceforge.net>, Jim Paris <jim@jtan.com>
Subject: Re: [1/3] block/ps3vram: Delete an error message for a failed memory
 allocation in ps3vram_cache_init()
Message-Id: <3xYjck14L0z9t42@ozlabs.org>
Date: Fri, 18 Aug 2017 22:51:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-07 at 20:09:20 UTC, Geoff Levand wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Cc: Jim Paris <jim@jtan.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fd1335e048a961ef63f7da1a0c8f39

cheers
