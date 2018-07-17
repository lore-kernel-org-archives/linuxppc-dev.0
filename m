Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41V3XB5v3MzF36n
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 12:05:30 +1000 (AEST)
In-Reply-To: <20180705084700.4410-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: remove POWER9 DD1 support
Message-Id: <41V3XB560nz9s1R@ozlabs.org>
Date: Tue, 17 Jul 2018 12:05:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-07-05 at 08:47:00 UTC, Nicholas Piggin wrote:
> POWER9 DD1 was never a product. It is no longer supported by upstream
> firmware, and it is not effectively supported in Linux due to lack of
> testing.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/2bf1071a8d50928a4ae366bb310883

cheers
