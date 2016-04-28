Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwKZf5QD6zDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 11:52:10 +1000 (AEST)
In-Reply-To: <1461068616-16646-1-git-send-email-rsalvaterra@gmail.com>
To: Rui Salvaterra <rsalvaterra@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rui Salvaterra <rsalvaterra@gmail.com>
Subject: Re: powerpc: wire up preadv2 and pwritev2 syscalls
Message-Id: <3qwKZf35WDz9t5s@ozlabs.org>
Date: Thu, 28 Apr 2016 11:52:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-19-04 at 12:23:36 UTC, Rui Salvaterra wrote:
> Wire up preadv2/pwritev2 in the same way as preadv/pwritev. Fixes two
> build warnings on ppc64.
> 
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d701cca6744fe0d67c86346dcf

cheers
