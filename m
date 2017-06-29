Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKb5PKXzDr4d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:23 +1000 (AEST)
In-Reply-To: <20170627070006.32132-1-santosh@fossix.org>
To: Santosh Sivaraj <santosh@fossix.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [1/2] powerpc/smp: Do not BUG_ON if invalid CPU during kick
Message-Id: <3wyzKb4nWqz9s65@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-27 at 07:00:05 UTC, Santosh Sivaraj wrote:
> During secondary start, we do not need to BUG_ON if an invalid CPU number
> is passed. We already print an error if secondary cannot be started, so
> just return an error instead.
> 
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f8d0d5dc641cd405ad40cb2498b04d

cheers
