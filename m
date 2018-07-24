Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg383RkxzDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:59:48 +1000 (AEST)
In-Reply-To: <20180430145558.4308-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [01/15] powerpc/powernv: opal_put_chars partial write fix
Message-Id: <41Zg380lfkz9s3N@ozlabs.org>
Date: Tue, 24 Jul 2018 23:59:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-30 at 14:55:44 UTC, Nicholas Piggin wrote:
> The intention here is to consume and discard the remaining buffer
> upon error. This works if there has not been a previous partial write.
> If there has been, then total_len is no longer total number of bytes
> to copy. total_len is always "bytes left to copy", so it should be
> added to written bytes.
> 
> This code may not be exercised any more if partial writes will not be
> hit, but this is a small bugfix before a larger change.
> 
> Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Patches 1-9 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bd90284cc6c1c9e8e48c8eadd0c795

cheers
