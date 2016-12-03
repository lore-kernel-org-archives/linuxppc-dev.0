Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW83k2F8mzDwB5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:31:14 +1100 (AEDT)
In-Reply-To: <20161126032031.12765-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64: place .text immediately following .head.text
Message-Id: <3tW83k1STcz9t1F@ozlabs.org>
Date: Sat,  3 Dec 2016 22:31:14 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-11-26 at 03:20:31 UTC, Nicholas Piggin wrote:
> Do not introduce any additional alignment. Placement of text section
> will be set by fixed section macros. Without this, output section
> alignment defaults to 4096, which makes BookE text section start at
> 0x1000 when it is expected to start at 0x100.
> 
> This was introduced by 57f266497d81 ("powerpc: Use gas sections for
> arranging exception vectors") and was caught with the scripted head
> section checker (not yet merged).
> 
> Fixes: 57f266497d81
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/dadc4a1bb9f0095343ed9dd4f1d9f3

cheers
