Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHK0nh9zDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:18:53 +1000 (AEST)
In-Reply-To: <1487313082-21316-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mpc52xx: Don't select user-visible RTAS_PROC
Message-Id: <3wJCHJ6kKYz9s0g@ozlabs.org>
Date: Thu,  4 May 2017 08:18:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-17 at 06:31:22 UTC, Michael Ellerman wrote:
> Otherwise we might select it when its dependenices aren't enabled,
> leading to a build break.
> 
> It's default y anyway, so will be on unless someone disables it
> manually.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/0cc68bfad45b47167c9d99cf560b50

cheers
