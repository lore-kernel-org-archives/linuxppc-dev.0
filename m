Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3dh80WMtzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:23:20 +1000 (AEST)
In-Reply-To: <20170410020404.11375-1-rashmica.g@gmail.com>
To: Rashmica Gupta <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: Re: powerpc/mm: Dump hash table
Message-Id: <3w3dh773XSz9sNg@ozlabs.org>
Date: Thu, 13 Apr 2017 21:23:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-10 at 02:04:04 UTC, Rashmica Gupta wrote:
> Current behaviour assumes that memory in RAM is contiguous and
> iterates from the start of RAM to (start + size of memory). When the
> memory isn't physically contiguous, this approach doesn't work.
> 
> If memory exists at 0-5 GB and 6-10 GB then the current approach will
> check if entries exist in the hash table from 0GB to 9GB. This patch
> changes the behaviour to iterate up to the end of RAM.
> 
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9e4114b3913cff37be509224116b6f

cheers
