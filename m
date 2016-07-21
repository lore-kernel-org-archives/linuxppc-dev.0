Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw9z41tYKzDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 21:09:36 +1000 (AEST)
In-Reply-To: <1467695057-12431-12-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [11/41] powerpc/dart: Use a cachable DART
Message-Id: <3rw9z36fnvz9snm@ozlabs.org>
Date: Thu, 21 Jul 2016 21:09:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 05:03:47 UTC, Benjamin Herrenschmidt wrote:
> Instead of punching a hole in the linear mapping, just use normal
> cachable memory, and apply the flush sequence documented in the
> CPC625 (aka U3) user manual.
> 
> This allows us to remove quite a bit of code related to the early
> allocation of the DART and the hole in the linear mapping. We can
> also get rid of the copy of the DART for suspend/resume as the
> original memory can just be saved/restored now, as long as we
> properly sync the caches.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c40785ad305b32e9b0b5fbc888

cheers
