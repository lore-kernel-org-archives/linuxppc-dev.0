Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR4QQ3hCDzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 22:33:34 +1100 (AEDT)
In-Reply-To: <20170103185828.31311-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc: implement clear_bit_unlock_is_negative_byte()
Message-Id: <3vR4QQ3Fpdz9s9j@ozlabs.org>
Date: Sun, 19 Feb 2017 22:33:34 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-01-03 at 18:58:28 UTC, Nicholas Piggin wrote:
> Commit b91e1302ad9b8 ("mm: optimize PageWaiters bit use for
> unlock_page()") added a special bitop function to speed up
> unlock_page(). Implement this for powerpc.
...
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d11914b21c4c21a294fe8937d66c1a

cheers
