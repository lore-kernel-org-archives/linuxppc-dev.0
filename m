Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tW80K0NxHzDw2Q
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 22:28:17 +1100 (AEDT)
In-Reply-To: <1479207578-8762-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64: Define ILLEGAL_POINTER_VALUE for 64-bit
Message-Id: <3tW80J5GSnz9t1d@ozlabs.org>
Date: Sat,  3 Dec 2016 22:28:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-15 at 10:59:38 UTC, Michael Ellerman wrote:
> This is used in poison.h to offset poison values so that they don't
> point directly into user space.
> 
> The value we choose sits roughly between user and kernel space, which
> means on their own the poison values don't point anywhere useful. If an
> attacker can cause an access at some offset from the poison value then
> we may still be in trouble, but by putting the poison values between
> user and kernel space we maximise the required size of that offset.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/f6853eb561fb9bfd56dfe0009f0ea2

cheers
