Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw9zD2x7BzDqZn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 21:09:44 +1000 (AEST)
In-Reply-To: <1467695057-12431-23-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [22/41] powerpc/mm: Move hash table ops to a separate structure
Message-Id: <3rw9zD13WGz9snm@ozlabs.org>
Date: Thu, 21 Jul 2016 21:09:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 05:03:58 UTC, Benjamin Herrenschmidt wrote:
> Moving probe_machine() to after mmu init will cause the ppc_md
> fields relative to the hash table management to be overwritten.
> 
> Since we have essentially disconnected the machine type from
> the hash backend ops, finish the job by moving them to a different
> structure.
> 
> The only callback that didn't quite fix is update_partition_table
> since this is not specific to hash, so I moved it to a standalone
> variable for now. We can revisit later if needed.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7025776ed1ebdfa1959932e7a4

cheers
