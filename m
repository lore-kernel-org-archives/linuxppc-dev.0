Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WNph4G4wzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:07:40 +1000 (AEST)
In-Reply-To: <20180711060258.14448-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc: Remove Power8 DD1 from cputable
Message-Id: <41WNpg2Jhwz9s7T@ozlabs.org>
Date: Thu, 19 Jul 2018 16:07:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-11 at 06:02:58 UTC, Joel Stanley wrote:
> This was added to support an early version of Power8 that did not have
> working doorbells. These machines were not publicly available, and all of
> the internal users have long since upgraded.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e11b64b1ef336f8976e5bf194b0eed

cheers
